Content-Type: multipart/mixed; boundary="===============3687810135454463266=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: iwd needs connman service?
Date: Tue, 19 Nov 2019 20:55:36 +0100
Message-ID: <baf56838-c87d-5c2f-ae07-324fed245e86@monom.org>
In-Reply-To: <d237df00-b930-7da6-8305-6c2d84a4179f@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3687810135454463266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18.11.19 19:55, Denis Kenzior wrote:
> Hi Jeff,
> =

> On 11/15/19 7:12 PM, Jeff Chua wrote:
>> Prior to Nov 09, I could connect with connman, but git pull after that =

>> doesn't work with connman service, and even with connman, I still =

>> can't iwd.
> =

> I suspect that connman has not been updated to iwd 1.0 APIs.=C2=A0 So you=
 may =

> be stuck with 0.23 or so until someone fixes ConnMan to use iwd 1.0+ =

> properly.

Current HEAD of iwd works just fine for me with ConnMan HEAD. Denis is =

right, the iwd plugin in ConnMan needs to be updated. It's my next item =

on my TODO list.

Thanks,
Daniel
--===============3687810135454463266==--

