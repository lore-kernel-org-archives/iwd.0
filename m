Content-Type: multipart/mixed; boundary="===============8653254153368422020=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] eapol: Store IP address in network byte order
Date: Fri, 13 Aug 2021 10:50:16 -0500
Message-ID: <b89baa49-9b0c-89a5-3695-2f565eb35734@gmail.com>
In-Reply-To: <20210807021048.321664-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8653254153368422020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/6/21 9:10 PM, Andrew Zaborowski wrote:
> Switch handshake_state's .client_ip_addr, .subnet_mask and .go_ip_addr
> from host byte order to network by order.
> ---
>   src/eapol.c | 12 ++++++------
>   src/p2p.c   |  2 +-
>   2 files changed, 7 insertions(+), 7 deletions(-)
> =


Patches 1, 3 and 4 applied, thanks.

Regards,
-Denis

--===============8653254153368422020==--

