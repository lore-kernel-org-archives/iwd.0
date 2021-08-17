Content-Type: multipart/mixed; boundary="===============5226112077332795180=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/5] test-runner: extend -S option
Date: Tue, 17 Aug 2021 11:45:00 -0500
Message-ID: <5bbb0124-0dbc-a053-9841-677f923c7e7a@gmail.com>
In-Reply-To: <20210817164501.195027-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5226112077332795180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/17/21 11:44 AM, James Prestwood wrote:
> The -S/--sub-tests option allows the user to specify a test file
> from inside an autotest. Inside this file there may also be many
> test functions. This option is being extended to allow running
> a single test function inside a test file. For example:
> =

> * Runs all test functions inside connection_test.py *
> ./test-runner -A some_test -S connection_test
> =

> * Runs only connection_test.py test_connect_success() *
> ./test-runner -A some_test -S connection_test.test_connect_success
> ---
>   tools/test-runner | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============5226112077332795180==--

