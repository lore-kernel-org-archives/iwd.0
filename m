Content-Type: multipart/mixed; boundary="===============5088236449132934945=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] ap: Don't use L_AUTO_FREE_VAR with l_settings
Date: Fri, 26 Feb 2021 11:12:10 -0600
Message-ID: <a8c8b169-c999-957f-9a56-95284ec56664@gmail.com>
In-Reply-To: <20210226161728.677701-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5088236449132934945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/26/21 10:17 AM, Andrew Zaborowski wrote:
> L_AUTO_FREE_VAR only causes l_free to be called on the variable that is
> freed and may leak the rest of the l_settings object's memory.
> ---
>   src/ap.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> =


Patches 1-4 applied,  thanks.

Regards,
-Denis

--===============5088236449132934945==--

