Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87E1F76DA
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788701; cv=none; b=A2FnklEFGeZA2oI74joths8HoLWL6/0CGU/TfrtrGA1aCZjbgvP5R4DeX+opqOeWFrwkqs8GjvfsKeeHulr08aV3B+IKisAsD1KQljpx3IC4N+3HiVJAlbed6yJp6ubNdOBSZogVqVLVIWZUTHdPrdiki/ZYFBgBF5Mu6nnzvc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788701; c=relaxed/simple;
	bh=6dGzUgmV8hmr+ZAw4Ng+PqcvsnLUSIVM+Yik9nqkulQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHl5+e0ipff+29VWceu/O2/Ju3cBw0HsFqDD29sHB2pUdiMBqHEgjkf/zsEKRERIOc14MmhtEobXef568O37UtwCpPPPti5NdBs5kIM7jiUTxmQokwaeSlFsJUhE30dWVf/m4+e8KxtqrjV0ZYFfg7V41EyMmHitOCa8+vMkGL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPSXMI5f; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPSXMI5f"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b155cca097so97714085a.1
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788698; x=1730393498; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qw9yv5XFSzNWtIpTJYor0Ne0PPxE0xaWpVmfDzCcKlw=;
        b=gPSXMI5f0Z2ixTAo1rwTAeplrQq52K8L/Q9/OMokqAY75J+1P+7woc3paubiX4X57Z
         2jpot4rXKnGM6x6yyyuQCX50wyC6MYLkUGYEki00ZE98vwkaUufoCf+cDAnA0cAXUvTI
         Lyw+jVMmWw7eTsgFU0xj1M9eyYfOkJjqxEkxPMXEgXlwJD9ZK/c9M4pshdRMNP3nMzql
         msDCbhrYqLIDw1VsOfZDyzV6de6lYmipJ1X6vm8U94Uzmc3YfVcbQArgDTtlKTBDC9ss
         LOeMZwf75h09iKJIwipFUAxqcKm1m+fs3gwbxbEqk3pFeu2wZMqnZOFoFiS/+pQVuB8V
         ixSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788698; x=1730393498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw9yv5XFSzNWtIpTJYor0Ne0PPxE0xaWpVmfDzCcKlw=;
        b=az6DEBqkOeOVWe+iFsBT6aYNN+zvpdoJWnLri+NXngX/mVu2vyzEoMViXmAx2RRQVe
         AQhJsebBYF+UI2thqAt2VJW+f05ItEeEEaadGgQjpio4iUnjvdkZ5/N9Q06+c9EU2SFq
         4/AeJo0VnNZGNYs0H1a5GVuZazpLcT+/JULaJqyym+MqAx4mUC/zDJnJp1guYkbCpH7Z
         oiPEj4vVHhnYsImDi2bQ7ffBNlfzjOX+bdQDAqFU0LzI+Az4IRCI+MB57SwH+GjNk39S
         warUHng9o0i6/abCcpIrAgTpbM1VB6tYQiKwIY76F69kcKn9PZdELQq/fIM6qZf13R8A
         TRsA==
X-Gm-Message-State: AOJu0YyMLfYUHTheaJLEnhsNqlbmRj4BVn/NVGA3CgBkWTp4KEs1bM/1
	lU99SqLKtrJXQRtIRAnp4YW74/yR86Qqd0ldjKjlgGtFbsfO5wGRJb0hUw==
X-Google-Smtp-Source: AGHT+IFHbBIvOJeY26s7OMy3/oyjBVyHL43HoeXOBgQGTNaXECcdirLxGx4QpzZDXBcpVnhgfDN8WA==
X-Received: by 2002:a05:620a:2409:b0:7b1:45f3:c28c with SMTP id af79cd13be357-7b1865e6445mr383774485a.16.1729788698554;
        Thu, 24 Oct 2024 09:51:38 -0700 (PDT)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659b98a6sm504982185a.15.2024.10.24.09.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:51:38 -0700 (PDT)
Message-ID: <ec368cb3-325e-4df5-aeaa-f84dc0641da6@gmail.com>
Date: Thu, 24 Oct 2024 09:51:35 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd 2.22 scan fails but... works ok with ConnMan
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Denis Kenzior <denkenz@gmail.com>
Cc: iwd@lists.linux.dev
References: <CF5A13CE-18AF-4A33-98F9-13FA353657C4@gmail.com>
 <38b1af93-83c8-4cfb-ae63-5e480ac4420b@gmail.com>
 <D6BB0209-39DB-430B-977A-955928ED3701@gmail.com>
 <d27c9f76-ee7f-4509-a05e-6e05ee444181@gmail.com>
 <A112F6DF-E1BE-4350-86DD-7A85BA4FC1CA@gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <A112F6DF-E1BE-4350-86DD-7A85BA4FC1CA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Piotr,

On 10/24/24 7:32 AM, Piotr Oniszczuk wrote:
> Pls see inline
>
>> Wiadomość napisana przez Denis Kenzior <denkenz@gmail.com> w dniu 24.10.2024, o godz. 16:00:
>>
>> Hi Piotr,
>>
>>>> What hardware is being used?
>>> this is allwinner h618 zero3 sbc with uwe5622 wifi chip.
>>> Kernel is 6.11.5 with uwe5622 driver backported from vendor bsp (https://github.com/warpme/minimyth2/blob/master/script/kernel/linux-6.11/files/0630-net-wireless-add-uwe5622-support-v20231020.patch)
>> So yet another non-upstream driver, sigh.
> Ah - believe me: mine frustration because of this is much bigger :-p
>
>>>>   Can you include iwmon output?
> After compiling nlmon now is much better: https://gist.github.com/warpme/4b21b51dd1e2c74075498acd9af5082d
>
>> Is this in any way related to the problem reported in this thread?
>> https://lore.kernel.org/all/CAOCHtYj9OjZGQ=G139i=KRRcxpFD-1=GSvUPmFYaqSvFz0NwJg@mail.gmail.com/
>>
> Indeed I saw this thread.
> Some time ago I was trying to play with iwd.cfg without success
> Maybe I put incorrect settings there?
>
> May you hint me what exactly I need to add in iwd.cfg?
>
> To load wifi kernel module I’m using: modprobe sprdwl_ng
>
> Btw: all was working ok few versions back of iwd/kernel
> Unfortunately I can’t say which change: iwd or kernel breaks iwd operation on uwe5622 wifi….
>     
>
Thank you for the iwmon logs, that really helped diagnose the issue. 
There are a few patches on the list that I just sent which will 
hopefully fix your problem. We identified a few separate issues:

  - Incorrect starting frequency for operating class 136
  - No check for the correct band when checking the e4 table
  - No check for the correct band when parsing the advertised 
frequencies from the kernel/driver

  Your hardware seems to be advertising some frequencies [1] which are 
not exactly common and this threw IWD for a loop and exposed several 
bugs. These fixes will basically disallow those frequencies, but we need 
to take a closer look at them to be able to parse them correctly.

[1] https://en.wikipedia.org/wiki/List_of_WLAN_channels#5.9_GHz_(802.11p)

Thanks,

James

