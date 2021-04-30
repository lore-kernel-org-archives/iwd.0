Content-Type: multipart/mixed; boundary="===============7692383506372000323=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 10:50:54 -0500
Message-ID: <867f64de-d259-050a-2e76-602e954094ab@gmail.com>
In-Reply-To: <5c24f37ffef628a67a1acc8143549191161f0c19.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7692383506372000323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/30/21 10:43 AM, James Prestwood wrote:
> Hi Denis,
> =

> <snip>
>>> +	if (info->cb)
>>> +		info->cb(netdev, 0, info->super.aa, info->user_data);
>>> +
>>
>> Do you need to set a flag of some sort to indicate that the info has
>> been filled
>> successfully?
> =

> As long as station behaves and doesn't try and roam prior to a
> successful the action frame callback I think we can guarantee it has

Always err on the side of paranoia :)

> been parsed. But in the future when we do multiple concurrent action
> frames we would need something to distinguish them in the queue, so
> I'll add a flag.
> =


Also, are you resetting netdev->ft_ds_info once CMD_Associate has been sent?

Regads,
-Denis
--===============7692383506372000323==--

