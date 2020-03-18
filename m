Content-Type: multipart/mixed; boundary="===============4950396147247720008=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/4] wiphy: add _generate_address_from_ssid
Date: Wed, 18 Mar 2020 13:10:54 -0500
Message-ID: <2fcf7527-d86b-2f26-8480-f96deb403dcb@gmail.com>
In-Reply-To: <20200318185420.11432-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4950396147247720008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/18/20 1:54 PM, James Prestwood wrote:
> This API is being added to support per-network MAC address
> generation. The MAC is generated based on the network SSID
> and the adapters permanent address using HMAC-SHA256. The
> SHA digest is then constrained to make it MAC address
> compliant.
> =

> Generating the MAC address like this will ensure that the
> MAC remains the same each time a given SSID is connected to.
> ---
>   src/wiphy.c | 34 ++++++++++++++++++++++++++++++----
>   src/wiphy.h |  2 ++
>   2 files changed, 32 insertions(+), 4 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4950396147247720008==--

