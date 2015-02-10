Schemas = {}

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


  avatarUrl:
    type: String
    optional: true
    autoform:
      omit: true


Contacts.attachSchema Schemas.Contacts