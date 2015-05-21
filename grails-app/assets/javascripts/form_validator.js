"use strict";

//
// Example form validator function
//
function FormValidator(formid) {
  $(formid).bootstrapValidator({
    message: 'This value is not valid',
    fields: {
      idname: {
        message: 'The id is not valid',
        validators: {
          notEmpty: {
            message: 'The id is required and can\'t be empty'
          },
          stringLength: {
            min: 8,
            max: 30,
            message: 'The id must be more than 8 and less than 30 characters long'
          },
          regexp: {
            regexp: /^[a-zA-Z0-9_\-\.]+$/,
            message: 'The id can only consist of alphabetical, number, dot, dash and underscore'
          }
        }
      },
      username: {
        message: 'The username is not valid',
        validators: {
          notEmpty: {
            message: 'The username is required and can\'t be empty'
          },
          stringLength: {
            min: 6,
            max: 30,
            message: 'The username must be more than 6 and less than 30 characters long'
          },
          regexp: {
            regexp: /^[a-zA-Z0-9_\.]+$/,
            message: 'The username can only consist of alphabetical, number, dot and underscore'
          }
        }
      },
      name: {
        validators: {
          notEmpty: {
            message: 'The name is required and can\'t be empty'
          }
        }
      },
      initials: {
        validators: {
          notEmpty: {
            message: 'The initials is required and can\'t be empty'
          }
        }
      },
      country: {
        validators: {
          notEmpty: {
            message: 'The country is required and can\'t be empty'
          }
        }
      },
      acceptTerms: {
        validators: {
          notEmpty: {
            message: 'You have to accept the terms and policies'
          }
        }
      },
      email: {
        validators: {
          notEmpty: {
            message: 'The email address is required and can\'t be empty'
          },
          emailAddress: {
            message: 'The input is not a valid email address'
          }
        }
      },
      website: {
        validators: {
          uri: {
            message: 'The input is not a valid URL'
          }
        }
      },
      phoneNumber: {
        validators: {
          digits: {
            message: 'The value can contain only digits'
          }
        }
      },
      zipCode: {
        validators: {
          usZipCode: {
            message: 'The input is not a valid US zip code'
          }
        }
      },
      password: {
        validators: {
          notEmpty: {
            message: 'The password is required and can\'t be empty'
          },
          identical: {
            field: 'confirmPassword',
            message: 'The password and its confirm are not the same'
          }
        }
      },
      confirmPassword: {
        validators: {
          notEmpty: {
            message: 'The confirm password is required and can\'t be empty'
          },
          identical: {
            field: 'password',
            message: 'The password and its confirm are not the same'
          }
        }
      }
    }
  });
}
