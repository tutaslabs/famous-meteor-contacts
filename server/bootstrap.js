Meteor.startup(function () {

    if (Contacts.find({}).count() === 0) {
        _(7).times(function(n) {
            var user = Fake.user();

            Contacts.insert({
                name: {
                    first: user.name,
                    last: user.surname
                },
                emails: [{label: 'Work', address: user.email}],
                priority: Fake.fromArray(['High', 'Medium', 'Low']),
                location: {
                    city: Fake.word(),
                    state: Fake.fromArray(STATES)
                },
                details: {
                    notes: Fake.paragraph(),
                    active: Fake.fromArray([true, false])
                },
                owner: 'public'

        },function (err) {
            if (err)
                console.log(err)
            })
        });
    }


    Accounts.config({loginExpirationInDays: 10});
    var i = Meteor.users.findOne({username: "admin"});
    if (!i) {
        Accounts.createUser({username: "admin",password: "ChangeMe"});
        var id = Accounts.createUser({username: "demo",password: "demo"});
        Meteor.users.update({_id: id},{$set: {emails: [{address: 'demo@demo.com',verified: false}]}})
        Meteor.users.update({_id: id},{$set: {'profile.name': 'demo'}});

    }



});


    Meteor.methods({
        initDB: function () {

            Contacts.remove({});


            Meteor.users.remove({});
            Accounts.createUser({username: "admin", password: "ChangeMe"});
            var id= Accounts.createUser({username: "demo", password: "demo"});
            Meteor.users.update({_id: id},{$set: {emails: [{address: 'demo@demo.com',verified: false}]}})
            Meteor.users.update({_id: id},{$set: {'profile.name': 'demo'}});

            _(7).times(function(n) {
                var user = Fake.user();

                Contacts.insert({
                    name: {
                        first: user.name,
                        last: user.surname
                    },
                    emails: [{label: 'Work', address: user.email}],
                    priority: Fake.fromArray(['High', 'Medium', 'Low']),
                    location: {
                        city: Fake.word(),
                        state: Fake.fromArray(STATES)
                    },
                    details: {
                        notes: Fake.paragraph(),
                        active: Fake.fromArray([true, false])
                    },
                    owner: 'public'
                },function (err) {
                    if (err)
                        console.log(err);
                });
            });

        },
        sendEmail: function (to,from, subject, text) {

            check([to, from, subject, text], [String]);
            // Let other method calls from the same client start running,
            // without waiting for the email sending to complete.
            this.unblock();

            // don’t allow sending email unless the user is logged in
            if (!Meteor.user())
                throw new Meteor.Error(403,"not logged in")

            // and here is where you can throttle the number of emails this user
            // is allowed to send per day

            Email.send({
                to: to,
                from: from,
                subject: subject,
                text: text
            });
        },
        changePasswords: function (doc,mod,docid) {
            check(doc,Schemas.PasswordForm)
            Accounts.setPassword(Meteor.userId(),doc.password)
        },
        newAccount: function (doc,mod,docid) {
            check(doc,Schemas.NewAccount)
            var id = Accounts.createUser({
                username: doc.username,
                email: doc.email,
                password: doc.password

            });
            Meteor.users.update({_id: id},{$set: {'profile.email': doc.email}} )
            return '';
        },
        updateEmail: function (userId,email) {
            Meteor.users.update({_id: Meteor.userId()},{$set: {emails: [{address: email,verified: false}]}})
        },
        deleteAccount: function (userId) {
            Contacts.remove({owner: userId});
            Meteor.users.remove({_id: userId});

            return '';
        },
        sendPasswordResetEmail: function (username) {

            var userId = Meteor.users.findOne({username: username})._id

            Accounts.sendResetPasswordEmail(userId);


        }
    });

