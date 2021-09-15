Content-Type: multipart/mixed; boundary="===============3388656726807733069=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 07/13] station: network: make ANQP watch a generic event
Date: Wed, 15 Sep 2021 15:49:47 -0500
Message-ID: <9c912302-4760-0157-2e32-d13454d73f6f@gmail.com>
In-Reply-To: 20210915173624.11917-7-prestwoj@gmail.com

--===============3388656726807733069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/21 12:36 PM, James Prestwood wrote:
> With the addition of OWE transition network needs to be notified
> of the hidden OWE scan which is quite similar to how it is notified
> of ANQP. The ANQP event watch can be made generic and reused to
> allow other events besides ANQP.
> ---
>   src/network.c | 15 ++++++++-------
>   src/station.c | 22 +++++++++++-----------
>   src/station.h | 12 ++++++------
>   3 files changed, 25 insertions(+), 24 deletions(-)
> =


Patches 7, 8 and 10 applied, thanks.

Regards,
-Denis

--===============3388656726807733069==--

