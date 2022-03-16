Content-Type: multipart/mixed; boundary="===============2179080961727525593=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] test-runner: add option to write final status to file
Date: Wed, 16 Mar 2022 17:50:19 -0500
Message-ID: <9a1924ed-c16a-668d-f100-ff3886f062ae@gmail.com>
In-Reply-To: 20220316222935.596505-1-prestwoj@gmail.com

--===============2179080961727525593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/16/22 17:29, James Prestwood wrote:
> Running the tests inside a VM makes it difficult for the host to figure
> out if the test actually failed or succeeded. For a human its easy to
> read the results table, but for an automated system parsing this would
> be fragile. This adds a new option --result <file> which writes PASS/FAIL
> to the provided file once all tests are completed. Any failures results in
> 'FAIL' being written to the file.
> ---
>   tools/test-runner | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2179080961727525593==--

