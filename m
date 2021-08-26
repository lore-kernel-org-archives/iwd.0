Content-Type: multipart/mixed; boundary="===============1746700551368098595=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] test-runner: inherit Popen by Process class
Date: Thu, 26 Aug 2021 08:57:02 -0500
Message-ID: <1fd19ba3-afad-8b03-adc8-1e4d1fe67d70@gmail.com>
In-Reply-To: <20210825221726.784086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1746700551368098595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/25/21 5:17 PM, James Prestwood wrote:
> The Procss class was doing quite a bit of what Popen already does like
> storing the return code and process arguments. In addition the Process
> class ended up storing a Popen object which was frequently accessed.
> =

> For both simplicity and memory savings have Process inherit Popen and
> add the additional functionality test-runner needs like stdout
> processing to output files and the console.
> =

> To do this Popen.wait() needed to be overridden to to prevent blocking
> as well as wait for the HUP signal so we are sure all the process
> output was written. kill() was also overritten to perform cleanup.
> =

> The most intrusive change was removing wait as a kwarg, and instead
> requiring the caller to call wait(). This doesn't change much in
> terms of complexity to the caller, but simplifies the __init__
> routine of Process.
> =

> Some convenient improvements:
>   - Separate multiple process instance output (Terminate: <args> will
>     be written to outfiles each time a process dies.)
>   - Append to outfile if the same process is started again
>   - Wait for HUP before returning from wait(). This allows any remaining
>     output to be written without the need to manually call process_io.
>   - Store ctx as a class variable so callers don't need to pass it in
>     (e.g. when using Process directly rather than start_process)
> ---
>   tools/test-runner | 228 +++++++++++++++++++++++-----------------------
>   1 file changed, 112 insertions(+), 116 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============1746700551368098595==--

