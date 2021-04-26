Content-Type: multipart/mixed; boundary="===============8953294540713498405=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] doc: Clarify settings in iwd.ap(5)
Date: Mon, 26 Apr 2021 11:22:03 -0500
Message-ID: <1ef9b4de-7f23-204b-aaf8-2b283266fc19@gmail.com>
In-Reply-To: <CAOq732JyYXZrd_2HHSB2iXQtRzrTTC9BhC4=FQhuABjv4ygqYg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8953294540713498405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/26/21 11:05 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Mon, 26 Apr 2021 at 17:53, Denis Kenzior <denkenz@gmail.com> wrote:
>>> -The group ``[IPv4]`` contains settings for IWD's built in DHCP server.=
 All
>>> -settings are optional.
>>> +The group ``[IPv4]`` contains settings for IWD's built-in DHCP server.=
 All
>>> +settings are optional.  They're used if network configuration was enab=
led as
>>> +described in ``iwd.config(5)``.  Omitting the ``[IPv4]`` group disables
>>> +network configuration and the DHCP server for this access point.
>>>
>>
>> Hmm.. If 'all settings are optional', then how do you know whether 'IPv4=
' group
>> was omitted on purpose or not?
> =

> Well, you have to assume everything in the config file is done on
> purpose.  I think this is the only place IWD looks at whether a group
> is present but this is the current behavior AFAIK.
> =


So your intent is to have an empty [IPV4] group (i.e. '[IPv4]' line with no=
thing =

afterward)?  This is a bit confusing since a user would simply omit the '[I=
Pv4]' =

line as well if all the options were the defaults...

Maybe mention the need for this line in the docs?  Or alternatively... Do w=
e =

even need the ability to turn of dhcp per profile?  Isn't =

EnableNetworkConfiguration enough?

Regards,
-Denis
--===============8953294540713498405==--

