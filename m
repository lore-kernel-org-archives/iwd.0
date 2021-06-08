Content-Type: multipart/mixed; boundary="===============6524596683295538495=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netconfig: Make gateway optional for client
Date: Tue, 08 Jun 2021 10:26:15 -0500
Message-ID: <44077381-037b-9071-fad7-ef1cac948458@gmail.com>
In-Reply-To: <20210608144229.256776-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6524596683295538495==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/8/21 9:42 AM, Andrew Zaborowski wrote:
> Don't require a gateway address from the settings file or from the DHCP
> server when doing netconfig.  Failing when the gateway address was
> missing was breaking P2P but also small local networks.
> ---
>   src/netconfig.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6524596683295538495==--

