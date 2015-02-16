

SimpleSchema.messages({
  "passwordMismatch": "Passwords do not match"
});



if Meteor.isClient
  Template.registerHelper "Schemas", Schemas

Schemas.LoginForm = new SimpleSchema
  username:
    type: String
    min: 3
  password:
    type: String
    min: 4

Schemas.ProfileForm = new SimpleSchema
  name:
    type: String
    min: 3
    optional: false
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
    optional: false

Schemas.PasswordForm = new SimpleSchema
  password:
    type: String
    label: "Enter a new password"
    min: 4
  confirmPassword:
    type: String
    label: "Enter the password again"
    min: 4
    custom: ->
      if this.value isnt this.field('password').value
        return "passwordMismatch"


Schemas.Contacts = new SimpleSchema

  name:
    type: Object

  'name.first':
    type: String
    label: 'First Name'
    autoform:
      'label-type': 'floating'
      placeholder: 'First Name'
    max: 200

  'name.last':
    type: String
    label: 'Last Name'
    autoform:
      'label-type': 'floating'
      placeholder: 'Last Name'
    max: 200

  emails:
    type: [Object]

  'emails.$.address':
    type: String
    regEx: SimpleSchema.RegEx.Email
    autoform:
      'label-type': 'placeholder'
      placeholder: 'Email Address'


  'emails.$.label':
    type: String
    label: 'Label'
    autoform:
      options: [
        {value: 'Work', label: 'Work'}
        {value: 'Home', label: 'Home'}
        {value: 'School', label: 'School'}
        {value: 'Other', label: 'Other'}
      ]


  priority:
    type: String,
    optional: true
    autoform:
      options: [
        {value: 'High', label: 'High'}
        {value: 'Medium', label: 'Medium'}
        {value: 'Low', label: 'Low'}
      ]
      type: 'select-radio'


  location:
    type: Object

  'location.city':
    type: String
    max: 200

  'location.state':
    type: String
    autoform:
      options: _.map STATES, (state) ->
        return {label: state, value: state}

  details:
    type: Object

  'details.notes':
    type: String
    label: 'Notes'
    optional: true
    autoform:
      rows: 10
      'label-type': 'stacked'

  'details.active':
    type: Boolean
    defaultValue: true

  createdAt:
    type: Date
    autoform:
      omit: true

  avatarUrl:
    type: String
    optional: true
    autoform:
      omit: true
  owner:
    type: String
    optional: false
    autoform:
      omit: true


Contacts.attachSchema Schemas.Contacts