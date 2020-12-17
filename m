Content-Type: multipart/mixed; boundary="===============4850835392860240606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Thu, 17 Dec 2020 10:09:23 -0600
Message-ID: <6ba237f4-90fb-f2e1-070a-ecc5d6b54579@gmail.com>
In-Reply-To: <CAOq732L12a-KSUS-inAn0wCgHLNTWFrUmaUHs+SE_Gz20=kSOQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4850835392860240606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/17/20 3:18 AM, Andrew Zaborowski wrote:
> On Wed, 16 Dec 2020 at 17:08, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 12/16/20 9:02 AM, Andrew Zaborowski wrote:
>>>> I actually really wonder about the utility of these p12 files.
>>>
>>> The utility is the same as of the PEM format.  However for me
>>> personally it's about supporting the popular formats (I think we're
>>> sitll missing one certificate format)
>>
>> Sure, I get that.  But I have to wonder if spending massive amounts of t=
ime
>> supporting something that is ultimately a dead end is a worthwhile exerc=
ise.
> =

> Why is it different than .pem, .crt, .key, .p7b, etc.?

The difference is that this format can't be embedded into our settings file=
 easily.

Don't get me wrong, I'm all for supporting all these file formats.   But as=
 I =

mentioned previously, we're already getting bitten by people putting certs =
into =

their home directory and having systemd deny iwd permissions to read them. =

Something that you can't troubleshoot without reading logs and knowing wher=
e to =

look.

The fix is to have the user modify systemd default permissions for iwd to a=
llow =

it to read user home directories (which it probably shouldn't), or forcing =
the =

user to put the files 'somewhere' accessible.  Either is terrible user =

experience...

So I think it would be unfortunate if NM was forced into doing the same as =
above =

on a larger scale.  Especially when multiple potentially sensitive files ar=
e =

involved which should be removed along with the network profile.  This is w=
hy I =

consider non-embeddable file types a dead end.  We either need to figure ou=
t how =

to embed them or do something else.

> =

>>
>> And I take it isn't possible for NM to convert these P12 files into some=
thing
>> more sensible like a PEM + encrypted private key PEM on the fly?
> =

> Without the password, no.  I still don't see the reason to force IWD's

Okay, that's what I thought.

> clients and/or users to do this when we can have ell seemlessly
> autodetect the formats and clients like IWD (or https implementations)
> can forget about it, I'm not sure why we're having this conversation.
No, no.  We're on the same page here with regard to auto-detection.  At lea=
st I =

don't think we disagree here...

> =

>>
>>>>
>>>> client_key_is_container would basically indicate whether the file was =
a p12 or
>>>> not.  If the p12 does not contain ca_certs, then this could be written=
 as:
>>>
>>> Is it sepcified by the user though?  As I said I think that's an
>>> unneeded complication for all parties.
>>>
>>
>> What is specified by the user?
> =

> client_key_is_container, does it come from a boolean setting? Or do
> you want ell to have a function that reads the file and detects the
> format, separate from the function that loads the file?

No boolean setting.  The file type would be auto detected as you propose up=
on =

loading.

> =

>> If ClientKey has a P12 format and you get both
>> the private key and certificate out of it, then you're done.
> =

> That's exactly what calling l_pem_load_container_file() does, so the
> clients don't have to worry about the 10 different file types.
> =

>>
>> I don't want users to produce files like:
>>
>> EAP-TLS-ClientKey=3D/some/path/file.p12
>> EAP-TLS-ClientCert=3D/some/path/file.p12
>> EAP-TLS-CACert=3D/some/path/file.p12
>>
>> It should be just
>> EAP-TLS-Certificates=3D/some/path/file.p12
> =

> I looked around a little for an indication that a .p12 file is ever
> used to store the user keypair (for client authentication) *and* the
> trusted CA set (for server authentication) but I can't find it, I

Here's one:
http://cubicspot.blogspot.com/2013/04/setting-up-wpa2-enterprise-aes-with.h=
tml

Certainly it would make sense to include the CA cert if you're already uplo=
ading =

a P12 container file with a user cert + user key.  Many orgs have went away=
 from =

running their own CA and use a public CA instead.  So that might explain wh=
y =

this is not that common.  Anyhow, this isn't that important.  If the CA is =
not =

included in the vast majority of cases, then it isn't included.

> don't believe this exists.  I also believe if some implementer wanted
> to support this -- it would be only for EAP, not other .p12 use cases
> (like https, .apk signing, etc.), so they'd go all the way and create

VPN comes to mind.  But then do we really care about other use cases just y=
et?

> a new format to store the full EAP configuration (Identity etc.) and
> certificates + keys in one file rather than use .p12.  If you've seen

Which is what Apple did with their .mobileconfig format.  And that's exactl=
y =

what our settings file with embedded certs is...

> something like this please re-check the details, I think you're
> talking about something different than .p12.
> =

> So you can't do either of the above, it's going to be something like:
>> EAP-TLS-ClientCert=3D/some/path/file1.p12
>> EAP-TLS-CACert=3D/some/path/file2.p12
> =


'Can't' might be a strong word.  'Might not be able to' is probably more =

accurate.  But anyway, if the p12 is only including user key / user cert, t=
hen =

thats what we have to work with.

Regards,
-Denis
--===============4850835392860240606==--

