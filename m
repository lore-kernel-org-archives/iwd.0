Content-Type: multipart/mixed; boundary="===============6051345660309944601=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] nl80211util: Fail in nl80211_parse_attrs if attribute
 missing
Date: Fri, 25 Oct 2019 13:53:27 -0500
Message-ID: <90330d42-152f-0cd3-51f7-f164dc18c62e@gmail.com>
In-Reply-To: <20191024043000.13687-5-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6051345660309944601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/23/19 11:29 PM, Andrew Zaborowski wrote:
> The users of this function expect an error return value if any of the
> attributes wanted was not present in the message.
> ---
>   src/nl80211util.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Nice catch.  Completely forgot about that check.  I fixed this slightly =

differently in commit 3b937424db9009e3978fdcb1295f25088ffc48b6

Regards,
-Denis

--===============6051345660309944601==--

