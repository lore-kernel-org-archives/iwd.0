Content-Type: multipart/mixed; boundary="===============3603850979681273612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] ap: Send a specific error message on async AP start
 failure
Date: Tue, 01 Jun 2021 10:18:03 -0500
Message-ID: <0d53e8c1-c9a3-9a93-b625-08d02827a2bf@gmail.com>
In-Reply-To: <20210528004737.2878442-5-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3603850979681273612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/27/21 7:47 PM, Andrew Zaborowski wrote:
> We generate the DBus error reply type from the errno only when
> ap_start() was failing synchronously, now also send the errno through
> the callbacks so that we can also return a specific DBus reply when
> failing asynchronously.  Thea AP autotest relies on receiving the
> AlreadyExists DBus error.
> ---
>   src/ap.c | 32 ++++++++++++++++++--------------
>   src/ap.h |  4 ++++
>   2 files changed, 22 insertions(+), 14 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3603850979681273612==--

