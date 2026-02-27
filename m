Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEE2620DE
	for <iwd@lists.linux.dev>; Fri, 27 Feb 2026 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772158966; cv=none; b=tsmN+d7NvNk9uOlm4vK/Tee07E91mm73Fph0lnz+taXmr/hnBu5ujepH2dsiYvmrhzk22vQJV+hjyddUs+jEkC68F//wGXZ0roNs+iM/bSiXdEl/bfdwWHoDqWfQKNyvWkyN7O9BS7Gw+cg84fqrrqfyRxmLs+krcDDReVGHWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772158966; c=relaxed/simple;
	bh=a2b2O6B6zWV2wK3IJ+NgGPvFqsJarsVoTMEYnfNMIT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=udOYlAInCgrS7Pc66ELbPvQ2vreuKKQwGyoOCzxfr/hpO8/QJkcNAGBR+821VTxuVluQyJ5I09r7yo8Q8hlBlfjfzXm6cVZU+lGcXBS8ProZxmGPOQJSCeei2PtiSoZdk0lgXb5dyMNtIQdUzKP7/+qJDPxzjZpiLseAKoDKsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akgJVdjN; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akgJVdjN"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-677bb1c3a9dso572951eaf.3
        for <iwd@lists.linux.dev>; Thu, 26 Feb 2026 18:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772158964; x=1772763764; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnG9dEdLo9hUpGHzV/6+fJeR/DOLW4Zsw/Gd85fDoGU=;
        b=akgJVdjNHtka1Hu64F6/d2fyUM/m+00+0l76RD0qJ2WSHc/rdzPmYWku4FncSnwdDL
         YH2S3nRoZniXH6fDgoFbCf4RsH0/ip7YdiVj8orDqI76gEz8uZw5Br3vZzwvXDfnoWSI
         7GA3+SIXRFsxrFk8caXDYOyo+Ze0/ZF9idfIHz0SeBov1ZviqOmJ53GeLCiT7DUqi7yA
         UVr8ee5/LJ5ollliiKgistWVRqkSubeL3suPkCeNziiPL3sQ9Y/v8TYqNslSEplRGTHv
         tE1WbH91eMTlf44t+VG33Gu9qOn7n7GfPk51W3DqBzQxWHUp7NSPihwlAOuXNNC/1VfX
         stgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772158964; x=1772763764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnG9dEdLo9hUpGHzV/6+fJeR/DOLW4Zsw/Gd85fDoGU=;
        b=TqnJbzUlTOWBHinjOf1DPkHffTFmRBX6e1OnJ9YSyI8vK5ODCpr5D/SC0NAuLbCPL4
         2ARXMNnSOHA4P6/cW5C/mH2tHFpJD1wuMnhxkxfGlQ73/kE1sKbu2dJtatQ5olkTRzxa
         XFrysrNRoOxf13EUjhmGTlybmXk+CSdo1kJZzAV9v/BskJd+MxRRZerKOzp73waEj2jh
         V/k4XVbcYJdN088AGpsw0oLvE9Coz3oir91p7WvTfvvOD/Wjh9RYr2eLvv0G86fh9tXV
         sp2wXjDoCVs1enFsnM9EG9ke1c3D+yXY+hwKt6tdW4udPeQD6etIH1Z1m++BoCkG5DDh
         r2xw==
X-Forwarded-Encrypted: i=1; AJvYcCXNzVwNc6ZmKSg8CR3x5du7xl3yQUpkKG2AKJwPd8zXn2n0fTD+SiVOpE0nOhYuuGvR5VY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxAE81phrYmpu+kiOvUOUV8+LzuuEres88gYVbuRqt6gOOMNMCy
	jGBywe5s5jqgqZiTK15CgLa+nw1eHPZG/qt7uzZWB5LVV6bUKIhTAb6MQLmr2w==
X-Gm-Gg: ATEYQzyP90vpWMO9sL7K4Ib1oOatBf8K/3YwJ/lELggONINlLGgJL2LH2+jutNMxcNy
	FTW+TFWcdClfeY3nCN59j9PiwFne5rabf8AdiRzHObYRJxPvHUerDQTWhFcvcA10k4j5UCBz0rS
	XbsZcCTIKHtLLTa159P+Y4HANLeVVcBfhOk2mEwZ/wT5j9jvgVeHAUCTVRYr3oCX/g1mgyCnetB
	fPjsBM/r9rbRC0V1KL4zQjf1IInxUQULlUxTAmgk8ZA5shch5aC5WJCQ8xDPBYFAUyYaoH6qR8X
	3KzOpYn5nGpJVwZ7InJN34VljWLMGJFAbyEzWOAKKAdOUX/9SRP8ZRlhiLvZjrJvpJKEk87uGz4
	WxFP7g/4gYLx/RgbX42KuWOyx+S/NLnyR/VtYILGLVpnzrm5rlaIHj4rR72+oOEK57pJjUSHIH6
	LDORrMRe/Gh7QKZ0IxflYHDL5+vgj0KHba
X-Received: by 2002:a05:6820:1990:b0:66e:4279:3e12 with SMTP id 006d021491bc7-679faf73d09mr989600eaf.65.1772158963673;
        Thu, 26 Feb 2026 18:22:43 -0800 (PST)
Received: from [172.16.49.130] ([70.112.199.191])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-679f2bcd3c5sm2590852eaf.1.2026.02.26.18.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 18:22:43 -0800 (PST)
Message-ID: <9acd2b81-5459-483a-a959-b33600d4f733@gmail.com>
Date: Thu, 26 Feb 2026 20:22:41 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwd not honoring AutoConnect=false
To: Alexander Huemer <ietha0weefee@xx.vu>, iwd@lists.linux.dev
References: <3p56uq4uboudnyuit6hlc3d4jvfllv3y7gjyor72vokio2msmy@xpfpjfqdknj7>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <3p56uq4uboudnyuit6hlc3d4jvfllv3y7gjyor72vokio2msmy@xpfpjfqdknj7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2/26/26 4:12 AM, Alexander Huemer wrote:
> Hi
> 
> I am using iwd 3.8 with systemd-networkd 257.9 on Debian stable (trixie)
> on an amd64 machine.
> There is a wireless network with a PreSharedKey with a .conf file in
> /etc/iwd that I do not want iwd to connect to automatically if the
> signal strength becomes better than an alternative.
> The manpage iwd.network advises to use

You talk about iwd.network manpage, but also about /etc/iwd.  Note that iwd 
network configuration details are typically stored in /var/lib/iwd.  The manpage 
mentions this explicitly.

Otherwise, there's just not enough information.  We'd really need some logs 
(i.e. produced by running iwd with the '-d' option) to comment further.

Regards,
-Denis
