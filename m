Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949241F8750
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449941; cv=none; b=sQpwls6k+B8VIdmbDDRwtK0zNqNfNGsWQWtKCEBfq1g9PF0XgEQalXuKuULCZUD96geqx5ElWkQZ5wsJoqP5Kh9uLrnVgjvEzLuE4UhcWUkt3VIliB2VOsJ+FgyfzAAVAeHr26lXIDHEBH4iCb5svD+QJ58x7UYM9IOADTAly6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449941; c=relaxed/simple;
	bh=gHjEmasTvtGa0DdbGjneWXc9vPsFuquCyeThfc6Xd2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKaXVN2dGneCFEthI2Zn4w/0Eagu0gp7WmAqT7MoAB/EdY4t6jM1eIQpsTcU06wU1Y/3MgZ1S2Xjb/v1qDtMNEs0VPYgBtqQp7CzojYerZNf7tbNa2ggWbpmR82LAULK1ATDrFTKI12s9VKQXdk11JLqPNC4WLVZrFD0zLtPhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E61di7hk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E61di7hk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso5718836b3a.0
        for <iwd@lists.linux.dev>; Mon, 05 May 2025 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746449939; x=1747054739; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjnRo3fuy+AfUrpMVe8Ov6cFX1Zjh9r+Ry3zQABR8tI=;
        b=E61di7hkZYwYYQWuVePOVbbQ3ZTUblZCwghw191EnIdaaKt/zNYelFPkQRp3/WEaJa
         vi9eC98Z5cWojuF93A6oroYX7yaA5728AqBjgr81CTeaDgfaG3lsqiYc/V9ePGlTqfdk
         Ng6EMZ0xE8bA5VeZuWWYjMlpoduy29/Yarg4KCpJSERbFHETVg6BDR1ReQJV5sKZlLfs
         Gs0M0fusUHiwmYg5qzUZ4f32eV/7KVASEaper2zjnwfGm0puqqKTchktLLm26c9perce
         YGyAj8n533+4ofX5o3v6+cBPOQlApJORxbkJHG+pZmqKAFQgWHhHW3MXqoYnxjd/tFgA
         wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449939; x=1747054739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjnRo3fuy+AfUrpMVe8Ov6cFX1Zjh9r+Ry3zQABR8tI=;
        b=WjdwtOF3Wf8InXgE98R/y+r51bbE5WIof3KAop1a72ZtMgH9rv4aqznovEJg4sIFdv
         VpiqLDU4Fnh/oepCdMusTZSp7BVrLjFC8XHz/eAS/LgqyxmWCO+ywyEYzZVl8L8Ejuc2
         Lr+bnsrHzaelvJ8PmMFONYLXlts/AiXrD6BzpdEO2mIgsj860hO25EGnR2fBBy/waGzf
         uuJ4uhlrwMuA2z6rY3vmd2Bp+QlqFj/9uL5lheqZdQWZlCy0WtvQ1xHVcjKMSfMvDvWu
         dpu8n3M7T6YtEP8NY0bPEE+QH5vUkKHQyQ3hDi5ecNbsXgk2XBQ6no7IGdgULuI5aoeN
         PaNw==
X-Gm-Message-State: AOJu0Yz3O0Rr+BR88LGFGf2/MuERjkW0nOkz7YXvjXxGyuiQcmwTX04m
	jPxPiHEr5uhKo22RJuzWEpKGq13xc4nq8lsVXgCd1R8TkZY4NGF1Y7CBcA==
X-Gm-Gg: ASbGncsacq4sOW0apKr1MlzevL3//JNdD4hJx5uCfzHQ1BD1nG4gFyFHs+ozpdyRKMx
	yThCHYZVrxi3EpsF5NPWswLUykN2zdv1fqUyIHs416B5AoutAgj9KYVZber0xZRz2mKzN8+gqGu
	/Fl0YTp1SyoVub+jPmnDqy1kJlzCN09TsfgG9KRDIO/1Ihk3k9kF7EXcL2DxY/SOqyZLcYaVmWK
	6Ow2aRmwTybzyq67FZC7YTaqdlxLQc+KFsjNjy1yHKFpr+50YgThZS6HJL2Q2cBKqqLkuKBwp0w
	DAJX8h28/Mfj+kVf0rnGC1kTJa6zj7kguf+Ry8KMMFmiCjONebU/vWe3atCsDFVhjiKtUM9cE4w
	fS7ZHMool2TsOOAsJ0zw=
X-Google-Smtp-Source: AGHT+IFfMofTBoFRVwJY4nPJgSapi347Hz/LrfJ0ITmOGmugjDTH5EMTxanyXqnBH2jLMf6zaizCsQ==
X-Received: by 2002:a05:6a00:2a0e:b0:73c:c11:b42e with SMTP id d2e1a72fcca58-74067439837mr13512673b3a.20.1746449938808;
        Mon, 05 May 2025 05:58:58 -0700 (PDT)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059063f7asm6646675b3a.150.2025.05.05.05.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 05:58:58 -0700 (PDT)
Message-ID: <a0745309-9d1a-4916-926e-2a6f3651186e@gmail.com>
Date: Mon, 5 May 2025 05:58:57 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] unit: check cipher support and cleanup in test-storage
To: Marcel Holtmann <marcel@holtmann.org>
Cc: iwd@lists.linux.dev
References: <20250505123540.281773-1-prestwoj@gmail.com>
 <80DB75BF-0D93-4432-879A-AFAC76B4BE8B@holtmann.org>
 <b640af88-c952-4cc5-8339-8a1e7cbf4658@gmail.com>
 <875EC3CF-922D-4A7B-A4A5-F2F7894BFBD8@holtmann.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <875EC3CF-922D-4A7B-A4A5-F2F7894BFBD8@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/5/25 5:55 AM, Marcel Holtmann wrote:
> Hi James,
>
>>>> The __storage_decrypt API requires AES_CTR so support should be
>>>> checked before running that test. In addition storage_exit was never
>>>> being called which leaves unbalanced mlock/munlock calls.
>>>> ---
>>>> unit/test-storage.c | 11 +++++++++--
>>>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/unit/test-storage.c b/unit/test-storage.c
>>>> index c40518e6..765d9967 100644
>>>> --- a/unit/test-storage.c
>>>> +++ b/unit/test-storage.c
>>>> @@ -44,12 +44,19 @@ static void test_short_encrypted_bytes(const void *data)
>>>>
>>>> int main(int argc, char *argv[])
>>>> {
>>>> + int ret;
>>>> +
>>>> l_test_init(&argc, &argv);
>>>>
>>>> storage_init((const uint8_t *)"abc123", 6);
>>>>
>>>> - l_test_add("/storage/profile encryption",
>>>> + if (l_cipher_is_supported(L_CIPHER_AES_CTR))
>>>> + l_test_add("/storage/profile encryption",
>>>> test_short_encrypted_bytes, NULL);
>>> just use L_TEST_FLAG_ALLOW_FAILURE instead.
>> Ok, new way of doing things I guess.
>>>> - return l_test_run();
>>>> + ret = l_test_run();
>>>> +
>>>> + storage_exit();
>>>> +
>>>> + return ret;
>>> I really prefer we keep “return l_test_run()” as the basics on how test case are run.
>>>
>>> Just put storage_init,storage_exit into the test case itself. I would just do system_key_set = false in the exit function.
>> I'm fine with this, but its actually not possible to perform the cleanup after a failed test. If we want to do this we need actual cleanup support in l_test. Looks like we'd need to add a destroy function to l_test_add_data_func().
>>
>> Does that sound ok?
> we can add that, but I don’t think it is needed. Every test case is run in its own process. And since you only have one test case at the moment, don’t over engineer this.
Yeah, but what I'm saying is that there is no way to perform cleanup if 
a test asserts. In this case though I actually don't think 
storage_exit() is technically needed since the OS process cleanup will 
munlock any pages. So for now I'll just add the flag and leave 
everything else as-is.
>
> Regards
>
> Marcel
>
