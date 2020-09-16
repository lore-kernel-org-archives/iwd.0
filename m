Content-Type: multipart/mixed; boundary="===============6675421093132532952=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] ap: Pass "ops" struct to ap_start()
Date: Wed, 16 Sep 2020 17:26:12 -0500
Message-ID: <4015cbdb-5bec-be54-b768-268d62b61eef@gmail.com>
In-Reply-To: <20200916091754.516851-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6675421093132532952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/16/20 4:17 AM, Andrew Zaborowski wrote:
> Pass the event callback function pointer in a "struct ap_ops" instead of
> as individual ap_start() argument to make adding new callbacks easier.
> ---
>   src/ap.c | 65 +++++++++++++++++++++++++++++++-------------------------
>   src/ap.h |  9 +++++---
>   2 files changed, 42 insertions(+), 32 deletions(-)
> =


Patches 1-5 applied, thanks.

Regards,
-Denis

--===============6675421093132532952==--

