Content-Type: multipart/mixed; boundary="===============1707461616810480327=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] manager: Retry the interface setup if we get an EBUSY
Date: Mon, 27 Jan 2020 17:27:24 -0600
Message-ID: <9be5aac1-feb9-5c3b-2b19-e6d3972445e5@gmail.com>
In-Reply-To: <CAOq732K6iEaVaH6cZze_B9_wfFELAe8aai4k+R_ngXP5VcvkjQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1707461616810480327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/27/20 5:32 PM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Mon, 27 Jan 2020 at 23:17, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 1/27/20 8:16 AM, Andrew Zaborowski wrote:
>>> Sometimes, at least with brcmfmac, the default interface apparently
>>> takes a moment to get created after the NEW_WIPHY event.  We didn't
>>> really consider this case in the NEW_WIPHY handler and we've got a race
>>> condition.  It fixes the following bug for me:
>>> https://bugs.archlinux.org/task/63912 -- tested by removing and
>>> re-modprobing the brcmfmac module rather than rebooting.
>>
>> So it looks like that bug report is really several different issues
>> (probably most due to the weirdly behaving brcmfmac driver).
>>
>> Issue #1: This was seemingly related to atheros drivers not reporting
>> NEW_WIPHY at all, yet reporting NEW_INTERFACE.  At least this seemed to
>> be the case based on one log I saw.
> =


Actually it occurs to me that this issue is likely #4 in disguise.

> Yep maybe shouldn't have linked that bug.  In any case that should be
> easy to work around but I'm surprised nl80211 doesn't enforce the
> consistency of these events.

It sort of does, but the driver can influence things.

>> Okay, so strictly speaking we probably don't need to issue a dump of the
>> interfaces.  It is only the wiphy dump that contains info that a
>> NEW_WIPHY event doesn't contain.  Interface dumps and NEW_INTERFACE
>> events are equivalent.
>>
>> Also, we can probably safely assume that this is a new wiphy just
>> plugged in or initialized, and it will create at most a single default
>> interface.
> =

> You mean once we've checked state->retry is true we can safely assume
> it's a new wiphy, right?  Then we could try deleting it, if that

right

> succeeds, creating our own interface and if not, setting use_default.
> But...
> =

>>   So an interface dump is pretty useless anyhow.
> =

> Right, but it's easier for us to use the same code path as with the
> initial interface dump.  It's a workaround for a specific issue on

The contents of NEW_INTERFACE is the same as GET_INTERFACE.  So you =

could simply invoke manager_get_interface_cb and =

manager_interface_dump_done..

> boot so I'm not sure the overhead is more important than easier to
> read code.

But why incur an extra round trip to the kernel if you don't have to? =

Not to mention that genl is a queue & async, so you can get weird =

message interleaving and your 'easier to read code' might not end up =

being so.

Regards,
-Denis
--===============1707461616810480327==--

