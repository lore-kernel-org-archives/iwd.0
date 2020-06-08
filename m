Content-Type: multipart/mixed; boundary="===============4738528763615151324=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Race condition between iwd and systemd-udevd
Date: Mon, 08 Jun 2020 10:23:14 -0500
Message-ID: <91304c94-36c8-302d-4f38-d55e56d04daf@gmail.com>
In-Reply-To: <CAO8sHcm=sgTvkyCWh1SD9PGUxB_L1cmEQS2sJTy6=PLKo3hNNw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4738528763615151324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daan,

On 6/7/20 1:46 PM, Daan De Meyer wrote:

<snip>

> I guess this would take some changes on iwd's side to check if udev is us=
ed on =

> the system and if so, wait until the relevant udev event before deleting =
any =

> default wlan0 interfaces. Would a patch implementing that be accepted?

I don't see why not, but with a constraint:  You can't introduce any new =

dependencies (like libudev, etc) to iwd or ell.

Regards,
-Denis
--===============4738528763615151324==--

