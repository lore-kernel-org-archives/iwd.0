Content-Type: multipart/mixed; boundary="===============1791126817926419422=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ap: Move AP parameters to a struct
Date: Thu, 27 Aug 2020 13:04:35 -0500
Message-ID: <3954ea56-e9c1-87d9-2054-e28072acabda@gmail.com>
In-Reply-To: <CAOq732+kOPkPm5=dx6NbkvZufp388GeVnj4EjzadTa7E23jnEA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1791126817926419422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 1:00 PM, Andrew Zaborowski wrote:
> On Thu, 27 Aug 2020 at 19:37, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Andrew,
>>
>>>> I do wonder why you decided to make authorized_macs into a double-leve=
l array
>>>> instead of just a flat one...  You can always realloc if you need to g=
row it..
>>>
>>> Right, I thought it's just more natural when you can access n'th
>>> element with array[n], or you can iterate like over a list like I did
>>> here.
>>> And you don't need to make assumptions about the length of the array.
>>
>> That just seems so wasteful though?  I mean each pointer is 8 bytes on 6=
4-bit,
>> more than you pay for the mac address itself.  Plus god knows how much y=
ou pay
>> in malloc overhead.  No point being wasteful unnecessarily.
> =

> In theory that makes sense, so yes, let me switch to an uint8_t array.
> =

> In practice there's going to be zero or one address and there can be
> only one such array per netdev.

Right, which is why I'd just use a single mac for now until you actually ha=
ve a =

use for multiple ones.  Keeps the code simple as well.

> =

>>
>>>>
>>>> I think eventually we probably want to make this a proper API.  like
>>>> ap_config_new, ap_config_set_ssid, ap_config_set_passphrase, etc.
>>>
>>> Do you mean eventually, or now?  I personally would prefer l_settings
>>> over that, once you add accessors it loses the benefit of a nice
>>> struct that can be read and written easily.
>>>
>> But this can be defined inside ap.c.  So opaque only to clients of ap.c.
> =

> I still can't see a benefit though (it's more code for the ap.c
> developer and more code for the user, possibly more bureaucracy (more
> back and forth on the mailing list to add a parameter).  I guess it's
> a question of preference, you may like a specific style enough that it
> outweights that.

I'd argue the opposite.  In the longer term you can transform the ap_config =

internals without affecting any clients.  Anyhow, this is not really import=
ant =

right now.  Feel free to proceed with the setup you have now.

> =

> Also l_settings is aonther option.

I know, and I told you to just pick one with the warning that ap_settings w=
ill =

likely end up having a more complex API in the long term.

> =

>> Do you
>> need to access the struct elsewhere?
> =

> I was thinking hypothetically a user could access config->channel
> after ap_start to learn what channel has been selected.

That seems like a candidate for ap_foo API.

> =

>> If so, then the whole blurb in the
>> documentation about ap_start taking ownership isn't really true...
> =

> If your structs aren't opaque then you don't need to own the struct to
> access it, you only need to adhere to instructions.  For example,
> don't acccess the struct after the owner has been freed.

Don't even think about it ;)  iwd is now roughly ~80kloc.  What you suggest=
 will =

break down quick at this level of complexity.

Regards,
Denis
--===============1791126817926419422==--

