Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786411F91C8
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448778; cv=none; b=CQfBgakWtB2JaAj9+arcuf8mH85UECSZ5S2tzfUD0QjHwvDcQA8hiqlE1IyhianrSMvGC/IUrEs/T2PGxFSLgMYK8583eUUvmUZp77jdZ2f/5U3H1bgCbWJNxfwsWxZ7T6XnrgaE0Wi+12JuG7e8UFQ3ez5PCsHoVkLe+HHu8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448778; c=relaxed/simple;
	bh=stsiyDWbuIpcyV1HwAKyCAxdZh6es1k4mQyzoxAlKBE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bmwCApyLMnNxe4fXCduxltsoWLBY1tQmkryGoYZf3VRcYDk/gAPRkR+2l1wQleMwjopy/d6NvVogMjCr87nPbPLQVlCwFQml420Ripvj5ZBxTE84s5QzdI9icwfXdJMOaz+CAwpYLoxmWCFkzRuv1PJoBRwzC6GWEGg8vsHuY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fee4.dip0.t-ipconnect.de [79.249.254.228])
	by mail.holtmann.org (Postfix) with ESMTPSA id 279F4CED0C;
	Mon,  5 May 2025 14:39:35 +0200 (CEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] unit: check cipher support and cleanup in test-storage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20250505123540.281773-1-prestwoj@gmail.com>
Date: Mon, 5 May 2025 14:39:24 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <80DB75BF-0D93-4432-879A-AFAC76B4BE8B@holtmann.org>
References: <20250505123540.281773-1-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi James,

> The __storage_decrypt API requires AES_CTR so support should be
> checked before running that test. In addition storage_exit was never
> being called which leaves unbalanced mlock/munlock calls.
> ---
> unit/test-storage.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/unit/test-storage.c b/unit/test-storage.c
> index c40518e6..765d9967 100644
> --- a/unit/test-storage.c
> +++ b/unit/test-storage.c
> @@ -44,12 +44,19 @@ static void test_short_encrypted_bytes(const void =
*data)
>=20
> int main(int argc, char *argv[])
> {
> + int ret;
> +
> l_test_init(&argc, &argv);
>=20
> storage_init((const uint8_t *)"abc123", 6);
>=20
> - l_test_add("/storage/profile encryption",
> + if (l_cipher_is_supported(L_CIPHER_AES_CTR))
> + l_test_add("/storage/profile encryption",
> test_short_encrypted_bytes, NULL);

just use L_TEST_FLAG_ALLOW_FAILURE instead.

> - return l_test_run();
> + ret =3D l_test_run();
> +
> + storage_exit();
> +
> + return ret;

I really prefer we keep =E2=80=9Creturn l_test_run()=E2=80=9D as the =
basics on how test case are run.

Just put storage_init,storage_exit into the test case itself. I would =
just do system_key_set =3D false in the exit function.

Regards

Marcel

