Content-Type: multipart/mixed; boundary="===============2487144934911833564=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] frame-xchg: Add no-cck-rate flag only for P2P
 interfaces
Date: Tue, 29 Sep 2020 13:15:13 -0500
Message-ID: <9b4a1cdb-99b0-6f8b-5db7-803131bd312e@gmail.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2487144934911833564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/29/20 11:37 AM, Andrew Zaborowski wrote:
> We want to use this flag only on the interfaces with one of the three
> P2P iftypes so set the flag automatically depending on the iftype from
> the last 'config' notification.
> ---
>   src/frame-xchg.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2487144934911833564==--

