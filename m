Content-Type: multipart/mixed; boundary="===============7260510703533229484=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] station: Move 'connected' logic out of enter state
 func
Date: Wed, 09 Oct 2019 17:06:36 -0500
Message-ID: <6ee4b7bf-2a6f-32b0-bf6b-b0a9e7091d7d@gmail.com>
In-Reply-To: <20191009215333.14547-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7260510703533229484==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/9/19 4:53 PM, Tim Kourt wrote:
> Previously, station state 'connected' used to identify an interface assoc=
iated
> with AP. With the introduction of netconfig, an interface is assumed to be
> connected after the IP addresses have been assigned to it. If netconfig is
> disabled, the behavior remains unchanged.
> ---
>   src/station.c | 41 +++++++++++++++++------------------------
>   1 file changed, 17 insertions(+), 24 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7260510703533229484==--

