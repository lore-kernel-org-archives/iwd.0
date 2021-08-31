Content-Type: multipart/mixed; boundary="===============0345630876526233110=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] netconfig: Apply MACs received in FILS IP Assigment
Date: Tue, 31 Aug 2021 10:09:16 -0500
Message-ID: <6f0b8910-a4ad-7177-6a57-a0a584d4471b@gmail.com>
In-Reply-To: <20210827030544.353932-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0345630876526233110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/26/21 10:05 PM, Andrew Zaborowski wrote:
> Use the MAC addresses for the gateways and DNS servers received in the
> FILS IP Assigment IE together with the gateway IP and DNS server IP.
> Commit the IP to MAC mappings directly to the ARP/NDP tables so that the
> network stack can skip sending the corresponding queries over the air.
> ---
>   src/netconfig.c | 119 +++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 98 insertions(+), 21 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============0345630876526233110==--

