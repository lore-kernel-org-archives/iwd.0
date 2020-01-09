Content-Type: multipart/mixed; boundary="===============9179432194537421397=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] unit: Add a test for building M8 encrypted settings
Date: Thu, 09 Jan 2020 14:11:15 -0600
Message-ID: <264fa923-14d3-9e9c-0e05-3438bc981996@gmail.com>
In-Reply-To: <20200109194019.8228-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9179432194537421397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/9/20 1:40 PM, Andrew Zaborowski wrote:
> There's are two changes to the example raw data in m8_encrypted_settings,
> one is to change the Network Index value to 1 and the other is to drop
> the Network Key Index attribute:
> =

> Network Index     R     Deprecated =E2=80=93 use fixed value 1 for
>                          backwards compatibility.
> =

> Network Key       O     Deprecated. Only included by WSC 1.0
> Index                   devices. Ignored by WSC 2.0 or newer
>                          devices.
> ---
>   unit/test-wsc.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
> =


I had to apply this manually since the '-' character above was non-ascii =

and git-am was confused.  Please make sure I didn't screw anything up.

Regards,
-Denis

--===============9179432194537421397==--

