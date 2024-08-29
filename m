Received: from mail-200167.simplelogin.co (mail-200167.simplelogin.co [176.119.200.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCB1A76A8
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=176.119.200.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938516; cv=pass; b=ScusAX5ZTRKgcvj2jV25DTQ20qOs0PjRfoFxPo8280m7BSaGFzFUFlVeryE9becIXFOU+ncXsnVaHL9p9oyMVO01Dpns72JeYZI4kAWZSB5LQyABjdg4AjHdA3q4H0RKMauaGwIn6xPqoO8w9owdNWfcUlRgUPl2lzC6pxXWq2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938516; c=relaxed/simple;
	bh=dUpKpiPa/NeOnHK71O8JnGjQDUdOFFXptHkI50vUbJA=;
	h=Date:MIME-Version:Subject:In-Reply-To:Content-Type:From:To:
	 Message-ID:References; b=akDlS6eU+Tnzmgp97B8h8aJ1FuDIMgBvr70U6sF06BgUbPIh04/bM2b7/99cqYTOd4+JvYWJxK4OJHJnnr/n1o9EvYA1qR1Z51Akn3SeVlrccwGpQOYbsUoQkQZB3MMXxTjUVuUWqUza5WUj+8rOM7ctuFZoFUzCYTEP4u+q7OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me; spf=pass smtp.mailfrom=slmail.me; dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b=jkw6KQLI; arc=pass smtp.client-ip=176.119.200.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=slmail.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=slmail.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=slmail.me header.i=@slmail.me header.b="jkw6KQLI"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1724937515;
	cv=none; b=lVrKDR8cK12+PHAlmw2hNTEZlkYFLXdSa7AIstOCTETCs3bfGXdEhi9xeBQRayBMgxGBDq1RRqvlLfnz4wcpj0a6ybskhGs7FYH9y84iGNPB3fUxR6q9llYsG67+vfR3v6K4o9y/UsbFBNBTyhDp19stdFk6dulfp5qxCzoMM9w34WRwJQ1Je5SSRPMlKALH1uB8zXbISwYYb1mNMCdouHZEvXT4r0ikQvNt74Gtb5WgcSPaeVDnI52xgRO7m3obj2/VZm8KV56GkbpGCpa1G8jhh1/o19qAgxPi9yN6HFK00a1m/jJQDcsLbm6/hxQ/LLZLPd0AONsn2o2J4duqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1724937515; c=relaxed/simple;
	bh=dUpKpiPa/NeOnHK71O8JnGjQDUdOFFXptHkI50vUbJA=;
	h=Date:Subject:In-Reply-To:From:To:References; b=UntSlpvvuhxGE8ml1KZiM36pYTygODOlZqljxMoeeMw0f7065ermLKf1TAVT2r61VtJfyBS+KQ4ybCm/4RzVdC8VoCxKnwFjhXgZ/MFpomGXKbcfmLHbR5XBtGum4FM/7UUJH9AA6NIFUpayQkF/sKBxiCRri+92aQSbz96SLW9S01TohjpRQvBXpxQKAQMow3QUmXZpndIZJ0BHVSfozmqc/StsLHy0kcNJyUJdGzXWSS4qiScBJnxpQyitxmRXwLbOokfV/vPhgmlkIUG2AAIzlk1lWuaPpwRZsJt/wm+BYCYVSJ8ZiYRFxZH0kSRZ+/wP9oSFtrRL+ekKYPenwQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slmail.me; s=dkim;
	t=1724937515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhV/b+IaIf1v1ghwumqQ/vmVBGrhWd8CZVzeXlZlXSg=;
	b=jkw6KQLIES+B4oUvvblQxzHJ46uMli+g3uVTYhyR/7pKPAl02jkZ7qf50W3sg7+4hTNKOe
	bC7b+Tfl0dOqRZ8CuwlQTyqDjapPlGGSQ68zZhPIJ7AZNGmHHBeOYiisqPuWvW2eg6Wyym
	1aqkgS7gDI+gEDIUrA+E3t7Z5+f1sEg=
Date: Thu, 29 Aug 2024 18:48:28 +0530
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: Build failure with GCC 14
In-Reply-To: <eaa91b3f-b8af-4c6a-bf40-6613d80d4ff5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
From: bbhtt <bbhtt.zn0i8@slmail.me>
To: James Prestwood <prestwoj@gmail.com>,iwd@lists.linux.dev
Message-ID: <172493751485.7.2131554893827444665.418884701@slmail.me>
References: <520f3ed2-79fe-4b91-9442-b219cb00732a@slmail.me>
 <eaa91b3f-b8af-4c6a-bf40-6613d80d4ff5@gmail.com>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 418884701
X-SimpleLogin-Want-Signing: yes

On 29/08/24 17:15, James Prestwood - prestwoj at gmail.com wrote:
> Hi,
> 
> On 8/28/24 9:13 PM, bbhtt wrote:
>> Hello I'm seeing a few build failures when building with GCC 14. Not sure what 
>> would be the place to report these.
>>
>> ```
>> monitor/main.c: In function ‘genl_lookup’:
>> monitor/main.c:328:30: error: passing argument 2 of ‘l_netlink_send’ makes 
>> pointer from integer without a cast [-Wint-conversion]
>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>       |                              ^~~~~~~~~~~~
>>       |                              |
>>       |                              int
>> In file included from ./ell/ell.h:17,
>>                  from monitor/main.c:43:
>> ./ell/netlink.h:34:59: note: expected ‘struct l_netlink_message *’ but 
>> argument is of type ‘int’
>>    34 |                                 struct l_netlink_message *message,
>>       | ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>> monitor/main.c:328:52: error: passing argument 5 of ‘l_netlink_send’ makes 
>> pointer from integer without a cast [-Wint-conversion]
>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>       | ^~~~~~~~~~~
>>       |                                                    |
>>       |                                                    long unsigned int
>> ./ell/netlink.h:37:58: note: expected ‘l_netlink_destroy_func_t’ {aka ‘void 
>> (*)(void *)’} but argument is of type ‘long unsigned int’
>>    37 |                                 l_netlink_destroy_func_t destroy);
>>       | ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>> monitor/main.c:328:9: error: too many arguments to function ‘l_netlink_send’
>>   328 |         l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
>>       |         ^~~~~~~~~~~~~~
>> ./ell/netlink.h:33:14: note: declared here
>>    33 | unsigned int l_netlink_send(struct l_netlink *netlink,
>> ```
>>
>> Thanks!
> 
> Looks like you just need to use a compatible ELL and IWD version. When APIs 
> change or are added in ELL and IWD depends on that we do a new release for both. 
> We don't really have a table explaining compatible version, which we probably 
> should.
> 
> Thanks,
> 
> James
> 
> 

Ok, thank you. I was trying to build iwd 2.19 with ell 0.68 since that had a new
release. I did pick up 3 patches regarding l_netlink_send API from iwd main
but hit the above issue with those 3 patches applied.

I'll wait for a new iwd release.

-- 
- bbhtt

https://bbhtt.github.io/

