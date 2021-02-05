Content-Type: multipart/mixed; boundary="===============8555866850217852725=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] auto-t: add API wait_for_object_change
Date: Fri, 05 Feb 2021 14:44:24 -0600
Message-ID: <6c435fae-0769-d559-073b-bad9921a9646@gmail.com>
In-Reply-To: <20210205190637.325992-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8555866850217852725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/5/21 1:06 PM, James Prestwood wrote:
> This is similar to wait_for_object_condition, but will not allow
> any intermediate state changes between the initial and expected
> conditions. This is useful for roaming tests when the expected
> state change is 'connected' --> 'roaming' with no changes in
> between.
> ---
>   autotests/util/iwd.py | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============8555866850217852725==--

