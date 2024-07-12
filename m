Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CA49638
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819503; cv=none; b=tRcCbTzm83ejXxgrqZcI5x70id9e6uDHFFFYyYKX0mTHGaNIM/5xLaWsARgkRa3/f2YUu9nE4f87T56DOEuQNxhn/PpeB1h1PEEEKFKlHiEwOAyARHF/7zBWTuuAuf97kemwv/NR/mlYZmAIHcWjrWdFn8WZBVoRzcbGapZzjiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819503; c=relaxed/simple;
	bh=rWmU2Z9f8izR7E7n30BJ0TfcOAcJR8JKQ9+1lp7OuEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DhG0B/lzMjcJT/sT7Dccfuz3qA+QudgCP5jltLsHn653dtiFM2zb3iPrAvshqGW2JT2VLDgvpgBwFKStqB6RwAgQ/c4XifrULzD3wwactLAtBJ1VX4vowGAuiURoEyId5oXasOkQtiNA3o4QHbz+puBlJrbutNHxq594lWeQr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0+yYe/B; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0+yYe/B"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70211abf4cbso1543671a34.3
        for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 14:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720819501; x=1721424301; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4+S/e7J2UYfIXax9ExiUbHGa0DcJoKCWSfcFloito0M=;
        b=J0+yYe/BRD9W4zzSCfd8oGimFZASbVa2QPAM0L3G2QliHq2QzgSdFar/D//8MSIFkT
         Xjr1Rcw3d1a2KRovBl2IX4M2SkKF0Vz5FongrAJNM87Pp3nicE8W77RnNtu9sVZCOEgG
         y0S7x3YcZyum0Av/ahXX1EvoN1gtCH/QD9VghlWk3Yue5pNISjSLBKvvx/FoUdNrNI7A
         CjYY6Epn3CwhekeGt4ea0yrpROxzo06Pr34U1bmXOB3Fo9A+P1nMgzQgUdvgbNQDBgY8
         EX60NGNln1yxB+o3xaPtoFZLPye9XYnlBYILgwpLOexrlWai1AMTfB95zUiWGUtl22jv
         Tiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720819501; x=1721424301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+S/e7J2UYfIXax9ExiUbHGa0DcJoKCWSfcFloito0M=;
        b=FjFo9citE0O2zkPDMGQR+bfV3unsYst9kWlWADHBDSERNX6U7naWcbd0vAcuVCfj5G
         2PhdZfOzdSOQrhObiOpqJhdkyRXrGchJVBQ108BrWyzx5IBBtcC7S8FZSCGzFXJcwCAN
         zEXi1E7a76Sw+kl9A85eBRa+SAwIWAAkIj3uwy6pHfJHCZHyS0SflE6mxV0QvJpaMuhL
         Gq6oRt/lw3uz6qphumKveidyaPTqBPjv8qc0pFQRFRgAg+lvh7kbPG/FMULC75iVwbB9
         YRmUpWnAMYlJ6r0+8AT/6G+t+2w6ovtnK+c4pVn/jyhgFccygsOUNNippJM/+JMHqq9x
         OLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2xlN32U+v525TTzJmGuz5VdBEWq11VfyHT5VmYRJYdm4xqotZk3Oq35uNh+fimkRo/ria93WEiKWCjbZW3P27swS4
X-Gm-Message-State: AOJu0YySVacWOu5e0oqAe61qBl9X5btueekS6U5PVL2EttzMIh2bkSnH
	9w8KmA9docxKbI+31nQA96iTG5X7tV0dUt3RGrCG1HuXpUjYowS6
X-Google-Smtp-Source: AGHT+IFXS6iiXzjWEP4PMPV1p5NDcPr0rKuwbLm0othlwwrz1sTenhlmiPO1HkCjeK/BwvsCG8mv+w==
X-Received: by 2002:a05:6830:4c5:b0:703:68c2:8356 with SMTP id 46e09a7af769-70375a1f063mr12785714a34.17.1720819501282;
        Fri, 12 Jul 2024 14:25:01 -0700 (PDT)
Received: from ?IPV6:2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3? ([2605:a601:ad99:2e00:e9ed:d1b6:6b3c:b7f3])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7044934ae4asm1166897a34.80.2024.07.12.14.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 14:25:01 -0700 (PDT)
Message-ID: <ed69aafd-d81b-4f8e-9907-383485d21aae@gmail.com>
Date: Fri, 12 Jul 2024 16:25:00 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] main: remove static from const strlen
To: Kasper Kantz <kasperkantz@outlook.com>, iwd@lists.linux.dev
References: <DM4PR14MB488070291579BF883BDD0195A8A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <DM4PR14MB488070291579BF883BDD0195A8A62@DM4PR14MB4880.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kasper,

On 7/12/24 2:32 PM, Kasper Kantz wrote:
>   src/p2putil.c: In function 'p2p_get_random_string':
>   src/p2putil.c:2641:37: error: initializer element is not constant     2641 |
>          static const int set_size = strlen(CHARSET);         |
>                       ^~~~~~
> ---
>   src/p2putil.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

I modified the prefix to read: p2putil: (s/main/p2putil)

Applied, thanks.

Regards,
-Denis
