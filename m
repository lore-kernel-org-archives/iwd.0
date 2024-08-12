Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFD18784F
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723482720; cv=none; b=hK/DSeO//AENJTm6Hl6dDOrUdlR5PVZjkH9+Y+bWRF3eM3aCTqoise4b7EeZyqcgkBi8JR3gYf0StkXlxHFmFDQtYhpQRXSZZWiOErCFyaFErE1KMVl4ZwRTRVaE7TviA6rUhrWzCFBKkTw3FRfnhYARnFQZwrTARyLZIF3JqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723482720; c=relaxed/simple;
	bh=url4iyXGlMJPjA7GgCXtQqENnW5oPsnU9VePd6pWABI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q/gL7eHYdo1JVWi3Q40heLA92BJkdJT3Etg0lyMKNmxi9wcWRfxRbO9CPtqSEZ1loJO3lnhC35Ksu07i3pClfM9b7c5JevfgyEJkBXxejuWRbehkDiDr2NSdw9bLDeH7rFtP0/YZ5f09GW5WvTL31Q7dsjVB9x2KWsx077sZz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj0h2itN; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj0h2itN"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-260e6dfc701so3218133fac.3
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723482718; x=1724087518; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FzBmfKh2tAgpT/9y4DDxfYZL2i1Le0yITbEYUuEVZs=;
        b=Lj0h2itNlqDOsvsBO65hujS1y2CcSLM2Ef8V57Ls6NZWTzN15MqukFsOyVu5Gm621b
         nRsSAe4pCbc3BqBv1+Bz0M21P/qX+u6HbTuqrQt2jjnTCE9mgwTiHZLFRQbfEb41sLVI
         hsAVtrpy0CuQNQJLLHwqLXSkI7XHx89YAuzt49FMCOId1frwCG8kma202VXskxiFZG+f
         dtpi/VJUHuwYUrlCQinZrHAJzeJvOKaGrBOsRAGJwkgxwIjxS6ux1UZSc+M5LHirYknp
         6MzvvT/QsrI2XUib+Nih3xbXjX3IKSv6VgHhewN5IJYjMzAEXjgxRtrwn0UEwC6fE1SO
         FUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723482718; x=1724087518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FzBmfKh2tAgpT/9y4DDxfYZL2i1Le0yITbEYUuEVZs=;
        b=cQkK/gLqQ4lLdWOJWKZABEQi0AJZwJyvw6WfndyRV3RZDepikH5PYAuTiwVxbpNBrM
         wI0/27whP3fS1B1/4N2axd48QkUd2rQE2tUpxrbbyz3naZeWOdfbZ4BmqxAwgvhMMAti
         TyIz2vuBBOrLhMnwxDQvbpCA9KXEYL/jN5kDheo9rFEuIYxb3HXxCPWYAQJYMFcgF6St
         bXWakZ7sIlfmE6O7nVhqr0EE93UoSWiAqPXMguBMx6nABBcnUtC3pol9S4TfsEVC/sbj
         1i4LWKu22TGfsNnxUe2s3mgYwKNO1SZPPTY+ouyQh2nafqoUxtfcfY8gkfIgH4b6tIJM
         JywQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKgDygPlF6Ty3Zd2Vr1fgXNFE5lVCi1nlAPgm6GaevROrzqnvSh016Byi/H4IJ7EBvwx02Oc2WUk137XwDrCnfeaSG
X-Gm-Message-State: AOJu0YxpRfuOUCFz+j4i9ZHoPvEXm30+t/NIt3dPkwFVFh3xwRwCBhhD
	zioXe85bFedhvD7TAih0raqiaITQXrq7zOSrLWx0cn7/vQw2aCg5
X-Google-Smtp-Source: AGHT+IFuHwOm5y1Gfa7ALwcWpnMkOd7AiOURIx0rny5QfFK309DdXD8UV1dhx8vK9KULVJHVlfjTDw==
X-Received: by 2002:a05:6870:1595:b0:25e:170b:4470 with SMTP id 586e51a60fabf-26fcb8929c8mr898080fac.50.1723482718169;
        Mon, 12 Aug 2024 10:11:58 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-26c723035a1sm1889126fac.57.2024.08.12.10.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:11:57 -0700 (PDT)
Message-ID: <029dd34f-74a3-436e-acd8-391dc1ca2638@gmail.com>
Date: Mon, 12 Aug 2024 12:11:56 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dbus: Add net.connman.iwd.BasicServiceSet
 interface
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240812154613.126522-1-prestwoj@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 8/12/24 10:46 AM, James Prestwood wrote:
> ---
>   src/dbus.h | 1 +
>   1 file changed, 1 insertion(+)
> 

All applied, thanks.

Regards,
-Denis

