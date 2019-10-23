Content-Type: multipart/mixed; boundary="===============0813238608719131710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] netdev: Add a wdev_id based frame watch API
Date: Tue, 22 Oct 2019 19:23:36 -0500
Message-ID: <db67b31f-f79d-351a-eb23-d270597e686e@gmail.com>
In-Reply-To: <CAOq732KNTME=saetsGbhU6mdx7cjUd_PJdGbGwBmZdDOO4=q9w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0813238608719131710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/22/19 6:56 PM, Andrew Zaborowski wrote:
> On Tue, 22 Oct 2019 at 16:53, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 10/21/19 8:55 AM, Andrew Zaborowski wrote:
>>> diff --git a/src/netdev.h b/src/netdev.h
>>> index 114a6035..624811b2 100644
>>> --- a/src/netdev.h
>>> +++ b/src/netdev.h
>>> @@ -197,6 +197,12 @@ uint32_t netdev_frame_watch_add(struct netdev *net=
dev, uint16_t frame_type,
>>>                                void *user_data);
>>>    bool netdev_frame_watch_remove(struct netdev *netdev, uint32_t id);
>>>
>>> +uint32_t netdev_wdev_frame_watch_add(uint64_t wdev_id, uint16_t frame_=
type,
>>> +                             const uint8_t *prefix, size_t prefix_len,
>>> +                             netdev_frame_watch_func_t handler,
>>> +                             void *user_data);
>>> +bool netdev_wdev_frame_watch_remove(uint32_t id);
>>> +
>>
>> So this really seems like it is jammed in there and it doesn't fit well.
>>
>> I think that we should make frame watches into a separate module now
>> that they no longer are only associated with a netdev.
> =

> Ok, I only put it inside netdev as an extension of the current api.

I know.  But given that this isn't urgent, I'd rather do it right the =

first time.

> =

>> This would allow
>> us to also track iftype changes and wipe out those frame watches that
>> are no longer registered with the kernel.  And also allow us not to try
>> and register frame watches that are already live (and bounce with an
>> -EAGAIN from the kernel).
> =

> The problem is how we will know what logic is implemented in the
> running kernel version.  We also watch iftype changes inside netdev so

Well, the particular fix from me got backported into every single LTS =

kernel.  So we just assume the fix is included.  Unless you want to go =

full wpa_s and use a separate socket for each frame watch.

> we can more comfortably do it here but I'm not sure it helps us.  In
> P2P I'm registering and unregistering the watches for specific
> operations and we never switch iftypes.  I think we should either have

Yeah, I think you have to bite the bullet and implement a separate =

socket for these.

> the kernel have a simple frame unregister command or keep all of the

Well, we tried that and got rejected.  See [1].  So as I said, until the =

kernel guys start treating nl80211 as a proper API, we have to live with =

this.

> watches for simplicity.

I don't think this is a good idea.  It will cause unnecessary wakeups =

and round trips into the kernel.  And any one of these is one too many.

> =

>>
>> We could also implement 'transient' frame watch sets by using a genl
>> socket dedicated to each set.  At least until the kernel people fix
>> their subsystem.
> =

> This sounds like it's much more costly in terms of syscalls and kernel
> work (and code) than occasionally getting the EAGAIN for a register
> command.

If you assume that frame watches are purged on iftype change, then most =

of the EAGAINs are only caused by netdev ifup/ifdown.  So those we can =

take care of easily.

Unnecessary wakeups should be avoided completely.  So if you have p2p =

frame watches and you can group them into a set to enable / disable, =

then they should be registered for on a separate socket.

> =

> Best regards
> =


Regards,
-Denis

[1] https://patchwork.kernel.org/patch/11131097/
--===============0813238608719131710==--

