STATES = [
    'AK', 'AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
];

Contacts = new Mongo.Collection('contacts');

Contacts.before.insert(function (userId, doc) {
    var gender = Random.choice(['men', 'women']);
    var num = _.random(0, 50);
    doc.avatarUrl = 'https://randomuser.me/api/portraits/thumb/' + gender + '/' + num + '.jpg';
});


