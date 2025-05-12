Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AE254B10
	for <iwd@lists.linux.dev>; Mon, 12 May 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077824; cv=none; b=Ze0Hag64GRwMstK8Yy2s/jTithBYqK8VbkBvu6OKbCkMJAeBNk65JycVkFU5V9f+rBFpOzLFZZhTsG0xBhYnuMcDICbZwXJgXHyiZ50n9++bh9PxnJYcY43nB3kRx7uwXctXX1+NWRZNICSJLlqXwt6hZ82IKae4ZhVYgAiPfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077824; c=relaxed/simple;
	bh=ADtzpXUXGE2jXGYfg4o7nOG60L1dvDFkJv3e/XmUrhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM9mHCKqtXl0EBnLQloRNZOuwQ90jIEc9Jtpb95oAeFjEZLUO7y+AnuKo4AhKZDNvDtfqRbdugc1G/lT8hti0NmXNTRyWeH0UMZ/DESTAQkUXqj/E+1Onp+JKifEb8punFkl04TMSx/C1KMH3D5wPL2uDvwrUpom9b+77eXBGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKU9Puwh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKU9Puwh"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c14235af3so3089037a34.3
        for <iwd@lists.linux.dev>; Mon, 12 May 2025 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747077822; x=1747682622; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDKzeFzR5r+xLOph+KpwYfzgeQPNqyDkASpiNDaPY4I=;
        b=QKU9PuwhJSs9JcFjAX2ke3st9ATnWjCqLyexqOlPtc7Ti0OLwYrFBSNeoAWUxR1TR8
         Lm6pZZh16Mw8EC9n+R7iTjNRWp9G7pP9pyfFANJR5hwKW13rrDFSQrYpfQWnh+1jyeVX
         19dLpBPjLw7uEFccAIDOsQ7Ib5QTO8y1l55MDWE1l7Nz/p0AmekpK3khNSx4qTM+ueuh
         AI2v95ThxCHPTaANptrJIya69ISmUHZIX0mysysgRMpvC8A8O4t18BSJqNh2zb76lHBb
         YzYLS/jcgLcyVeb4McRh+6KXvTxpgjJYUM/p5tiVelGh4AZsm2vMbsh/6TbhxEuCl8PL
         RFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077822; x=1747682622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDKzeFzR5r+xLOph+KpwYfzgeQPNqyDkASpiNDaPY4I=;
        b=Z1n4mqC6oEYZmkbi8B4LSuzfdvq6nfN7yM+FU0HzPXFvAQAMZ/pAR3G0VmLF4G0Id5
         feBhNUvyS/JlDjmZTIG410TvnTsD15fEgQBHjAbLzZp83FisYmGNdHLhmiA3NYqYrmIK
         Ln2iDCk4gVME/x9oqYUL6/6JeD2xmmTEfnndbRmktubAxs7r+Stfmb6EvKQJ85bWg8v4
         HIyaV4H5T2saKUoB6W/RcVa8vfqZW3/HDqBeeh8jJbBFM0BBNchz6MwA6n1/B5lD7JLb
         gFZ/UOzEYQP0A5GWWxKjhNMI66m+prlYxqDlh//9efijSojuPC73lCBVeXLunt3833T1
         uWYg==
X-Gm-Message-State: AOJu0YxL8+uKrph67XwUlJPWa2oJ2iVI8DZDboXxfvnQrhkInqMKCl8V
	GT3V9bEfN+jPGTEq4Mb9MybzMfnqVVaYCrxC7AXB0/6rOiCJkR2+
X-Gm-Gg: ASbGncs59t5sJXiyDzp/YafnOpwpwoCLLD4P3xby+4W+tyHeRlY5oyVXIrwYpPirFKo
	Wp9O4zhESC22C3PI7hXwwGxUQybS+2PSlJmTa2CvOAxjZ4U/vInTag4Yuwv6kt4y9lYBQDVn6yv
	Yxr3rHEzYPd45qeO3/I1z5ItBIcWKbsmcxpvILLOds92fuIklUvvCu0v3L//QEV69vPpUbpRzDY
	04f4s3Pqnjna9LkQgQyHUOwH2KGmc4N1BVD00jBCco0v7/j3AxqFNBtnqcUazJMZPO4t2DiJpWh
	r8rtXiPIHMx6fNtiKmv5PTl7cG+NchGxj1iiEF2eSSKOzP8BBAcejsK2h9Xs31AT18kNiui3Shu
	QtedHR4cK5aqFeA1j
X-Google-Smtp-Source: AGHT+IFSd32YCSNXp1V0D3fib/EM+o2DmdixiF3jx/WA8ZiRXxhPajH9YFfnQP9Bei1nraiFBtC9kA==
X-Received: by 2002:a05:6870:4790:b0:2d4:ea06:b11 with SMTP id 586e51a60fabf-2dba41f6d18mr8396254fac.7.1747077822417;
        Mon, 12 May 2025 12:23:42 -0700 (PDT)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-732264b0403sm1666901a34.18.2025.05.12.12.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 12:23:42 -0700 (PDT)
Message-ID: <797eb196-8634-4e2f-adf0-457600627f1e@gmail.com>
Date: Mon, 12 May 2025 14:23:41 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linksys router incorrectly showing as WEP?
To: Bryce Johnson <bryce@redpinelabs.com>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <CADXxVSKPz7o3TT18hCqzz=3MMWrE69NbaBDLSHFBfoRDq5VT7w@mail.gmail.com>
 <d6050f21-98ad-4b1d-a3ca-1d0be7ff7f15@gmail.com>
 <CADXxVS+kVrO=0rBs7E2sTssP2LNpBQLwGq_anKB80gWvCagTrw@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CADXxVS+kVrO=0rBs7E2sTssP2LNpBQLwGq_anKB80gWvCagTrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 5/12/25 1:24 PM, Bryce Johnson wrote:
> Hi James,
> 
>>
>> Could you grab an iwmon pcap of this? Here you can see how the security
>> level is determined, and its quite basic:
>>
> 
> I'll give that a try, unfortunately I didn't have CONFIG_NLMON in the
> kernel, I'll add that in now. They are also going to ship me the
> problem router so I'll try and repo the issue in person, hopefully a
> little more easily.
> 

This info would also show up in an air capture if iwmon is not available.

Regards,
-Denis
