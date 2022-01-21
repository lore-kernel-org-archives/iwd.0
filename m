Content-Type: multipart/mixed; boundary="===============7832236407648087595=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Fri, 21 Jan 2022 21:54:12 +0100
Message-ID: <C89738C5-2123-43B8-8164-89EAA037DD89@holtmann.org>
In-Reply-To: 17408ff42d125f331b1acde2ef733dd7b7f86e90.camel@gmail.com

--===============7832236407648087595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>>>> There has been interest in enabling IWD users to store their
>>>>> network
>>>>> credentials in some encrypted form. Recently systemd added
>>>>> support
>>>>> for
>>>>> passing secrets/credentials to services only accessible by the
>>>>> service
>>>>> they are intended. This provides a clean way of obtaining a
>>>>> secret
>>>>> key
>>>>> which IWD can use to encrypt anything it writes to the FS. In
>>>>> addition
>>>>> there is no hard dependency on systemd since the credential is
>>>>> provided
>>>>> as a file (i.e. no Dbus API or linked library etc).
>>>>> =

>>>>> At the moment setting up the IWD service to use this feature
>>>>> will
>>>>> be
>>>>> left up to the user. But setting this up is very straight
>>>>> forward.
>>>>> I
>>>>> used docs for systemd-creds (Example 2):
>>>>> =

>>>>> https://www.freedesktop.org/software/systemd/man/systemd-creds.html
>>>>> =

>>>>> The only difference is the --name argument should be iwd-
>>>>> secret.
>>>>> =

>>>>> Note: systemd version 250 is required.
>>>>> =

>>>>> The reason this is being sent as an RFC is because of some open
>>>>> questions
>>>>> I had and wanted feedback on:
>>>>> =

>>>>> 1. What options specifically do we want encrypted? These
>>>>> patches
>>>>> only
>>>>>    address Passphrase and PreSharedKey but really any option
>>>>> could
>>>>> be
>>>>>    encrypted. Obviously we would also want 802.1x secrets, but
>>>>> are
>>>>> there
>>>>>    other non-obvious options with privacy concerns?
>>>> =

>>>> we only need to encrypt things that are provided by the user. If
>>>> we
>>>> wouldn=E2=80=99t ask the user for it, then it is not worth while
>>>> protecting.
>>> =

>>> Ok, another option would be encrypting the entire [Security] group
>>> and
>>> assume anything here should be secure. This would actually make
>>> things
>>> quite a bit cleaner, and may be the only solution with how we do
>>> the
>>> 802.1x profiles since they are recursive.
>> =

>> any setting that gets asked by the user via the agent is worth
>> protecting, the rest is not worth it.
>> =

>> As pointed out in the other review, you need to also have some sort
>> of random nounce stored in plaintext. So besides the
>> PassphraseEncrypted, you also need PassphraseSalt or similar. And
>> then your salt value + SSID for example will be used as IV/Nounce
>> into the crypto.
> =

> Yes I realized this after sending it.
> =

>> =

>>>>> 2. What is the stance on existing provisioning files? Currently
>>>>> these
>>>>>    changes overwrite any existing files with the new *Encrypted
>>>>> options
>>>>>    automatically. Is this desirable? or should user have to
>>>>> opt-in
>>>>> their
>>>>>    existing provisioning files.
>>>> =

>>>> The problem arises that you no longer can move from one machine
>>>> to
>>>> the next without re-entering your secrets. So I guess this only
>>>> desirable if the master key is part of your users keyring. If you
>>>> have 200 PSKs entered and you set up a new machine, you now end
>>>> up
>>>> having to re-enter these as you go visiting new networks.
>>> =

>>> How would this work though? The user would have to either manually
>>> encrypt the settings/group or have some way to tell IWD to do it?
>>> =

>>> I think the act of enabling the main.conf option would be enough,
>>> and
>>> we could emphasise this in the docs. Yes this means you cannot go
>>> back
>>> but if you really had 200 profiles you absolutely could not lose
>>> you
>>> probably should have those saved somewhere else, offline.
>>> =

>>> Also, really the only security benefit (above what we do now) is
>>> when
>>> using a TPM meaning you couldn't move the profiles between machines
>>> regardless.
>> =

>> So this is pretty neat for embedded devices. Let say you have a
>> weight scale with WiFi. This way you can ensure with a single system
>> key that all your credentials are protected. If you throw the device
>> away or brick it, it ensures that nobody can easily read it out by
>> just mounting the disk/flash.
>> =

>> For a desktop system it is ok, if you have a capable admin/user that
>> knows what they are doing. If you don=E2=80=99t they are going to scream=
 at
>> your if they move to a new system and all their WiFi is gone. If a
>> MacBook or iPhone upgrade of mine would loose me all my PSKs, I would
>> be rather mad at somebody.
> =

> Yeah I see how this could upset someone, I'm just not sure how we
> accomplish this in a clean way. Either the user has to manually encrypt
> it (which is awful), or we need to provide an additional setting or API
> to say "I want to encrypt this" (which just feels redundant since
> they've set the main.conf option already).

I don=E2=80=99t have an answer for this, I am just pointing it out as a maj=
or detail that needs to be documented in big letters.

Regards

Marcel

--===============7832236407648087595==--

