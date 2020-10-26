Content-Type: multipart/mixed; boundary="===============0481994544008170917=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] auto-t: only return expected number from list_devices
Date: Mon, 26 Oct 2020 14:27:29 -0500
Message-ID: <9b3276fc-93d7-ca62-c490-ea0087c1ee93@gmail.com>
In-Reply-To: <20201023221900.1974722-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0481994544008170917==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/23/20 5:19 PM, James Prestwood wrote:
> If the caller specifies the number of devices only return that many.
> Some sub-tests may only need a subset of the total number of devices
> for the test. If the number of devices expected is less than the total
> being returned, python would throw an exception.
> ---
>   autotests/util/iwd.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0481994544008170917==--

