/* Copyright 2014-2015 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package ikakara.exampleout.command

import org.springframework.web.multipart.commons.CommonsMultipartFile

import grails.validation.Validateable
import groovy.transform.ToString

import ikakara.awsinstance.util.FileUtil

@ToString(includePackage=false, includeNames=true, ignoreNulls=true)
@Validateable(nullable=true)
class VideoCommand {
  static public final String THUMBNAILS_EXT = 'png'
  static public final String THUMBNAILS_TYPE = 'image/png'

  CommonsMultipartFile uploadFile
  String videoExtension
  String tempFilename
  File tempFile
  File thumbFile

  String getVideoNameExt() {
    return "${tempFilename}.${videoExtension}"
  }

  String getThumbNameExt() {
    return "${tempFilename}.${THUMBNAILS_EXT}"
  }

  VideoCommand withVideoFilename(String filename) {
    (tempFilename, videoExtension) = FileUtil.splitFileNameExtension(filename)
    return this
  }

  static constraints = {
    uploadFile validator: { file, obj ->
      println "IN VALIDATOR uploadFile ${file} ${obj}"
      if(file) {
        if(file.isEmpty() || file.getSize() == 0) {
          //errors.rejectValue 'uploadFile', 'video.uploadFile.invalidfile', [file.getOriginalFilename()] as Object[], "Video upload failed. Invalid file ${file.getOriginalFilename()}. Please try again."
          return ['invalidfile', file.getOriginalFilename()]
        } else if (file.getSize() > FileUtil.VIDEO_SIZE_LIMIT) {
          //errors.rejectValue 'uploadFile', 'video.uploadFile.filetoolarge', [file.getSize()] as Object[], "Video upload failed. Video too large (${file.getSize()}). Please try again."
          return ['invalidfile', file.getSize()]
        } else {
          def (isValid, extension) = FileUtil.getValidExtension(file.getOriginalFilename(), FileUtil.ACCEPTABLE_VIDEOFILE_TYPES)
          obj.videoExtension = extension // save extension to obj
          println "IN VALIDATOR uploadFile ${file} ${obj} ${extension}"
          if(!isValid) {
            //errors.rejectValue 'uploadFile', 'video.uploadFile.invalidtype', [extension] as Object[], "Video upload failed. Invalid file type (${extension}). Please try again."
            return ['invalidtype', extension]
          }
        }
      }
    }
  }

  @Override
  protected void finalize() throws Throwable {
    try {
      cleanup();        // close open files
    } finally {
      super.finalize();
    }
  }

  public void cleanup() {
    if(uploadFile) {
      uploadFile = null
    }
    if(tempFile) {
      tempFile.delete()
      tempFile = null
    }
    if(thumbFile) {
      thumbFile.delete()
      thumbFile = null
    }
  }
}
