Content-Type: multipart/mixed; boundary="===============5440471689970740333=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] autotests: p2p: Make waiting for dhclient more reliable
Date: Tue, 30 Nov 2021 15:49:27 -0600
Message-ID: <3cb67672-85e1-c785-bc2a-3f08f001da85@gmail.com>
In-Reply-To: 20211122144237.647864-1-andrew.zaborowski@intel.com

--===============5440471689970740333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/22/21 8:42 AM, Andrew Zaborowski wrote:
> Make sure we wipe the leases file both for server and client, so that
> dhclient doesn't try to re-use leases from previous tests (should really
> happen) and waste time waiting for a reply.  Extend the timeout from 1s
> to 5s, sometimes it takes dhclient 1s just to start.  Disable verbose
> mode if not needed to avoid dhclient stalling if the pipe is not being
> read.
> ---
>   autotests/testP2P/connection_test.py | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============5440471689970740333==--

