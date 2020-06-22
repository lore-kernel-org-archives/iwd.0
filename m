Content-Type: multipart/mixed; boundary="===============6603490317888339454=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 4/6] frame-xchg: refactor to work with offchannel module
Date: Mon, 22 Jun 2020 15:03:52 -0500
Message-ID: <5ed8ec95-5175-c844-750b-1ba8b7940890@gmail.com>
In-Reply-To: <7cf16a2fc43591bb0355c07fed2b004a20f444a4.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6603490317888339454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>>> -void frame_xchg_stop(uint64_t wdev_id);
>>> +void frame_xchg_stop(uint64_t wdev_id, uint32_t id);
>>
>> Do we even need the wdev_id here now? Also, should this be _cancel?
> =

> It just made the lookup easier, but yeah we could iterate each queue in
> the phy list. And yeah, I could change that to _cancel.
> =


Hmm, how so? I don't even see wdev_id being used now.

Regards,
-Denis

--===============6603490317888339454==--

