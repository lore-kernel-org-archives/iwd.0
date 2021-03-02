Content-Type: multipart/mixed; boundary="===============3267915969671953304=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] test-runner: fix duplicate process output
Date: Tue, 02 Mar 2021 10:38:08 -0600
Message-ID: <dd6c67e6-ae27-efd3-eabc-0b5d47c859c3@gmail.com>
In-Reply-To: <20210302163029.1980263-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3267915969671953304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/2/21 10:30 AM, James Prestwood wrote:
> Process output was being duplicated when -v was used. This was
> due to both stderr and stdout being appended to the write_fd list
> as well as stderr being set to stdout in the Popen call.
> =

> To fix this only stdout should be appended to the write_fd list,
> but then there comes a problem with closing the streams. stdout
> cannot be closed, so instead it is special cased. A new
> verbose boolean was added to Process which, if True, will
> cause any output to be written to stdout explicitly.
> ---
>   tools/test-runner | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> =

> v2:
>   * Added check for self.verbose so long running
>     processes get an IO watch and can actually
>     print to the console with -v.
> =


Applied, thanks.

Regards,
-Denis

--===============3267915969671953304==--

