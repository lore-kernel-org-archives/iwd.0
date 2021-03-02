Content-Type: multipart/mixed; boundary="===============7675300106645870005=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] test-runner: fix duplicate process output
Date: Tue, 02 Mar 2021 08:25:49 -0800
Message-ID: <6dbaef93a68004a9db2c9705b00a9512f06a6e6c.camel@gmail.com>
In-Reply-To: <20210301234133.1966359-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7675300106645870005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There seems to be an issue with this patch that Andrew found, please
wait for v2.

Thanks,
James

On Mon, 2021-03-01 at 15:41 -0800, James Prestwood wrote:
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
>  tools/test-runner | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> =

> diff --git a/tools/test-runner b/tools/test-runner
> index eab0f0ab..6e8966f4 100755
> --- a/tools/test-runner
> +++ b/tools/test-runner
> @@ -174,6 +174,7 @@ class Process:
>  		self.write_fds =3D []
>  		self.io_watch =3D None
>  		self.cleanup =3D cleanup
> +		self.verbose =3D False
>  =

>  		if not namespace:
>  			self.output_name =3D '/tmp/%s-out' % self.name
> @@ -195,8 +196,7 @@ class Process:
>  		if ctx:
>  			# Verbose requested, add stdout/stderr to write
> FD list
>  			if self.name in ctx.args.verbose:
> -				self.write_fds.append(sys.__stdout__)
> -				self.write_fds.append(sys.__stderr__)
> +				self.verbose =3D True
>  =

>  			# Add output file to FD list
>  			if outfile:
> @@ -234,7 +234,7 @@ class Process:
>  				self.io_watch =3D
> GLib.io_add_watch(self.stdout, GLib.IO_IN,
>  								self.io
> _callback)
>  =

> -		self.pid =3D subprocess.Popen(self.args,
> stdout=3Dself.stdout, stderr=3Dsubprocess.STDOUT,
> +		self.pid =3D subprocess.Popen(self.args,
> stdout=3Dself.stdout, stderr=3Dself.stdout,
>  						env=3Denv,
> cwd=3Dos.getcwd())
>  =

>  		print("Starting process {}".format(self.pid.args))
> @@ -261,6 +261,9 @@ class Process:
>  =

>  			self.write_fds =3D []
>  =

> +		if self.verbose:
> +			sys.__stdout__.write(self.out)
> +
>  		print("%s returned %d" % (args[0], self.ret))
>  		if check and self.ret !=3D 0:
>  			raise
> subprocess.CalledProcessError(returncode=3Dself.ret, cmd=3Dself.args)
> @@ -284,6 +287,9 @@ class Process:
>  		for f in self.write_fds:
>  			f.write(data)
>  =

> +		if self.verbose:
> +			sys.__stdout__.write(self.out)
> +
>  		return True
>  =

>  	def __del__(self):

--===============7675300106645870005==--

