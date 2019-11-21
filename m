Content-Type: multipart/mixed; boundary="===============0440621442959306870=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] p2putil: Replace free with clear in function names
Date: Thu, 21 Nov 2019 14:03:33 -0600
Message-ID: <20e17797-1a57-b85b-441c-3724ff8de3f0@gmail.com>
In-Reply-To: <20191121201557.16506-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0440621442959306870==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/21/19 2:15 PM, Andrew Zaborowski wrote:
> All these functions free up the resources used by the struct but don't
> free the struct itself (allowing it to be static) so rename the
> functions to avoid confusion.
> ---
> The patch probably would be easier to read without -n / -u
> ---
>   src/p2putil.c | 132 +++++++++++++++++++++++++-------------------------
>   src/p2putil.h |  30 ++++++------
>   2 files changed, 81 insertions(+), 81 deletions(-)
> =


Patch 1 & 2 applied, thanks.

Regards,
-Denis

--===============0440621442959306870==--

