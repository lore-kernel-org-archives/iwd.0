Content-Type: multipart/mixed; boundary="===============2207703301903541735=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 10:59:13 -0500
Message-ID: <ec2716cd-6631-f1ab-da4a-bddc08f98336@gmail.com>
In-Reply-To: <41866af323fb5d52f6ac8194f5d1859d4ac32f9d.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2207703301903541735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Also, are you resetting netdev->ft_ds_info once CMD_Associate has
>> been sent?
> =

> No, and actually I think it can be reset right
> inside netdev_fast_transition_over_ds. Once the handshake has been set-
> up it isn't needed.
> =


OK, but it should be reset in all cases, including if we do a FT-over-Air.

Regards,
-Denis
--===============2207703301903541735==--

