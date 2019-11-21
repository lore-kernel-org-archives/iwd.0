Content-Type: multipart/mixed; boundary="===============4932360816481830414=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] anqp: Only register for frames on station interfaces
Date: Wed, 20 Nov 2019 20:33:35 -0600
Message-ID: <6b0e3612-646a-54ce-7619-e167df7a8a96@gmail.com>
In-Reply-To: <20191120222346.7881-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4932360816481830414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/20/19 4:23 PM, Andrew Zaborowski wrote:
> Check the iftype before registering ANQP on new interface.
> =

> Not that the check here and in rrm.c (which already checks the iftype)
> may need to be extended to run on NETDEV_WATCH_EVENT_UP because a device
> could be created with a different iftype and then have the iftype changed
> before powering up.
> ---
>   src/anqp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> =


Patches 1-5 applied, thanks.

Regards,
-Denis

--===============4932360816481830414==--

