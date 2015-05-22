package ikakara.exampleout.platform

import static org.springframework.util.StringUtils.hasText

import org.springframework.context.ApplicationContext
import org.springframework.context.ApplicationContextAware

import grails.util.Holders

import ikakara.awsinstance.util.FileUtil
import ikakara.orguserteam.dao.dynamo.IdFolder
import ikakara.exampleout.command.VideoCommand

public class StorageService implements ApplicationContextAware {
  static transactional = false

  static public final String FOLDERS_BASE = 'folders'
  static public final String VIDEOS_PATH = '/videos/'
  static public final String THUMBNAILS_PATH = '/thumbnails/'

  def awsStorageService
  ApplicationContext applicationContext

  def list(IdFolder folder) {
    def objListing = awsStorageService.getPublicObjectList(FOLDERS_BASE, folder.id)
    def list = objListing?.getObjectSummaries().collect {
      return awsStorageService.getPublicURL(it.key)
    }
    return list
  }

  def save(IdFolder folder, VideoCommand videoCommand) {
    if(videoCommand.uploadFile) {
      def fullKey = folder.id + VIDEOS_PATH + videoCommand.videoNameExt

      if (awsStorageService.putPublicBytes(FOLDERS_BASE, fullKey, FileUtil.readAllBytes(videoCommand.tempFile), videoCommand.uploadFile.getContentType(), [date:(new Date()).toString()])) {
        def uploadedFullFileUrl = awsStorageService.getPublicObjectURL(FOLDERS_BASE, fullKey)
        log.info("Uploaded video: ${uploadedFullFileUrl}")
      } else {
        log.error("save failed: ${fullKey}")
      }
    }
    if(videoCommand.thumbFile) {
      def fullKey = folder.id + THUMBNAILS_PATH + videoCommand.thumbNameExt

      if (awsStorageService.putPublicBytes(FOLDERS_BASE, fullKey, FileUtil.readAllBytes(videoCommand.thumbFile), videoCommand.THUMBNAILS_TYPE, [date:(new Date()).toString()])) {
        def uploadedFullFileUrl = awsStorageService.getPublicObjectURL(FOLDERS_BASE, fullKey)
        log.info("Uploaded thumbnail: ${uploadedFullFileUrl}")
      } else {
        log.error("save failed: ${fullKey}")
      }
    }
  }

  def delete(IdFolder folder, VideoCommand videoCommand) {
    if(videoCommand.videoNameExt) {
      // delete video
      def fullKey = folder.id + VIDEOS_PATH + videoCommand.videoNameExt
      awsStorageService.deletePublicObject(FOLDERS_BASE, fullKey)
      // delete thumbnail
      fullKey = folder.id + THUMBNAILS_PATH + videoCommand.thumbNameExt
      awsStorageService.deletePublicObject(FOLDERS_BASE, fullKey)
    }
  }

}
