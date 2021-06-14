Content-Type: multipart/mixed; boundary="===============0301173264612082830=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] autotest: Improve cleanup in testP2P
Date: Mon, 14 Jun 2021 09:09:44 -0500
Message-ID: <90f32845-f9b4-01cc-ff92-8059cc388822@gmail.com>
In-Reply-To: <20210610210352.329398-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0301173264612082830==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/10/21 4:03 PM, Andrew Zaborowski wrote:
> Make sure some of the processes and files created are also cleaned up on
> failure so that the next chance has a chance to succeed anyway.
> ---
>   autotests/testP2P/connection_test.py | 31 +++++++++++++++++++++-------
>   autotests/util/wpas.py               | 11 ++++------
>   2 files changed, 27 insertions(+), 15 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0301173264612082830==--

