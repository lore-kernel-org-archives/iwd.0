Content-Type: multipart/mixed; boundary="===============0608998863349921251=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] peap: Extend EAP Extensions to handle multiple TLVs
Date: Thu, 12 Dec 2019 15:14:01 -0600
Message-ID: <820309f5-55be-dded-06da-c1d05ddc4106@gmail.com>
In-Reply-To: <20191212201016.18072-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0608998863349921251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 12/12/19 2:10 PM, Tim Kourt wrote:
> The handler for EAP Extensions has been modified to support multiple
> TLV types instead of the single Result TLV. This will allow to handle
> the other TLVs such as Crypto-Binding TLV.
> ---
>   src/eap-peap.c | 125 ++++++++++++++++++++++++++++++++++++++++----------=
-------
>   1 file changed, 88 insertions(+), 37 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0608998863349921251==--

