Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943C41C63
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449750; cv=none; b=Vt6Kg7gri9rV8M+ZBZemSTee1gSFCy4i7/7Ox+dqrtIhTM40Royf2FyE7hQ5Mjmb0nEvj5ghU4ImLJxlbAHjm4ywz8gpW9WXeM6i0b6g6ajlAG19j+CN1jqzmHnGcrEdyQDnTkeIqMcWGLTrtYhT5H3abiM+xrCfa9ltcRHNyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449750; c=relaxed/simple;
	bh=by+bSVr/8lo6aZNCzCJoha5yVuR+jJe4sEwTxFMns+0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=N4fq+CnEfaMPwCyizY6tIDrwQHzFRpHLla2IpYZIyHLjPIn8TdHsSbz3T73lzedbx/CeCibc3gw4e4z7YDdHFgsTviLEVR+mIMBACCiJ3r0VoQYKeSKJo6o7NPO6WHTiCj4yyJK7TLAT7DcDO8VBlNAsicqFuR+tnnUMOx0yGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fee4.dip0.t-ipconnect.de [79.249.254.228])
	by mail.holtmann.org (Postfix) with ESMTPSA id 4802FCED0D;
	Mon,  5 May 2025 14:55:47 +0200 (CEST)
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
In-Reply-To: <b640af88-c952-4cc5-8339-8a1e7cbf4658@gmail.com>
Date: Mon, 5 May 2025 14:55:35 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <875EC3CF-922D-4A7B-A4A5-F2F7894BFBD8@holtmann.org>
References: <20250505123540.281773-1-prestwoj@gmail.com>
 <80DB75BF-0D93-4432-879A-AFAC76B4BE8B@holtmann.org>
 <b640af88-c952-4cc5-8339-8a1e7cbf4658@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi James,

>>> The __storage_decrypt API requires AES_CTR so support should be
>>> checked before running that test. In addition storage_exit was never
>>> being called which leaves unbalanced mlock/munlock calls.
>>> ---
>>> unit/test-storage.c | 11 +++++++++--
>>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/unit/test-storage.c b/unit/test-storage.c
>>> index c40518e6..765d9967 100644
>>> --- a/unit/test-storage.c
>>> +++ b/unit/test-storage.c
>>> @@ -44,12 +44,19 @@ static void test_short_encrypted_bytes(const =
void *data)
>>>=20
>>> int main(int argc, char *argv[])
>>> {
>>> + int ret;
>>> +
>>> l_test_init(&argc, &argv);
>>>=20
>>> storage_init((const uint8_t *)"abc123", 6);
>>>=20
>>> - l_test_add("/storage/profile encryption",
>>> + if (l_cipher_is_supported(L_CIPHER_AES_CTR))
>>> + l_test_add("/storage/profile encryption",
>>> test_short_encrypted_bytes, NULL);
>> just use L_TEST_FLAG_ALLOW_FAILURE instead.
> Ok, new way of doing things I guess.
>>=20
>>> - return l_test_run();
>>> + ret =3D l_test_run();
>>> +
>>> + storage_exit();
>>> +
>>> + return ret;
>> I really prefer we keep =E2=80=9Creturn l_test_run()=E2=80=9D as the =
basics on how test case are run.
>>=20
>> Just put storage_init,storage_exit into the test case itself. I would =
just do system_key_set =3D false in the exit function.
>=20
> I'm fine with this, but its actually not possible to perform the =
cleanup after a failed test. If we want to do this we need actual =
cleanup support in l_test. Looks like we'd need to add a destroy =
function to l_test_add_data_func().
>=20
> Does that sound ok?

we can add that, but I don=E2=80=99t think it is needed. Every test case =
is run in its own process. And since you only have one test case at the =
moment, don=E2=80=99t over engineer this.

Regards

Marcel

