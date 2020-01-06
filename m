Content-Type: multipart/mixed; boundary="===============9131749009194730787=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] netdev: Replace bool randomize_mac with specific
 address
Date: Mon, 06 Jan 2020 11:51:02 -0600
Message-ID: <43a3191e-1ede-a20d-0589-ee927d305665@gmail.com>
In-Reply-To: <20191219035059.15214-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9131749009194730787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/18/19 9:50 PM, Andrew Zaborowski wrote:
> Allow netdev_create_from_genl callers to draw a random or non-random MAC
> and pass it in the parameter instead of a bool to tell us to generating
> the MAC locally.  In P2P we are generating the MAC some time before
> creating the netdev in order to pass it to the peer during negotiation.
> ---
>   src/manager.c | 22 ++++++++++++++++++----
>   src/netdev.c  | 45 ++++++++++++++++++++++-----------------------
>   src/netdev.h  |  3 ++-
>   3 files changed, 42 insertions(+), 28 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============9131749009194730787==--

