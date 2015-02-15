STATES = [
    'AK', 'AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
];

Contacts = new Mongo.Collection('contacts');


Contacts.before.insert(function (userId, doc) {

    if (Meteor.isClient) {
        if (!userId) {

            App.alert('Must log in to add contacts');
            return false;
        }
    }


    var gender = Random.choice(['men', 'women']);
    var num = _.random(0, 50);
    doc.avatarUrl = 'https://randomuser.me/api/portraits/thumb/' + gender + '/' + num + '.jpg';
    if (!doc.owner) {
        if (!userId || Meteor.user().username == 'admin') {
            doc.owner = 'public'
        }
        else {
            doc.owner = Meteor.userId();
        }
    }
    doc.createdAt = Date.now();
});

Contacts.before.remove(function (userId,doc) {

    if (Meteor.isClient) {
        if (!userId) {

            App.alert('You must first log in to delete');
            return false;

        }
    }

    if (Meteor.userId() && Meteor.user().username == 'admin')
        return true;
    if (Meteor.isClient) {
        if (doc.owner == 'public') {

            App.alert('Can not remove public contacts');
            return false;
        }
    }

    return true;

})
