Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D7168AE8
	for <iwd@lists.linux.dev>; Tue,  7 May 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098993; cv=none; b=DICppq4HZyJ9eV9DbMLjrIeUIOEVRk28VzfHR2s74pfcKzava/KWUBMqQvGIU12NsriEsFSYfomhNmSVCum2o320IjcqdodOKz0md0wQgDt8XfWnxcLBXTV+jGgZb83A8gJ68mvrMQBmTxas0XC+/Q2xSkKXE6RfRBOonAQmSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098993; c=relaxed/simple;
	bh=cqlWF+8r2tYa1Dc0CkZpYmbBN/lgZarwAJxoX/PH5Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bu0knr//wgMSidYEC+MTYghW6QDyBVYI3uFMdv3D7tUyhgwbn8VXoVbtLWhROdxY1DnSAGp+A6K0anzT+/bWeGldHg95GRhkClubS31gQhJzp4v/shGWL4KZeKc8QQdmzeaZq/mVriL8qiZdf/ca4pTqFHuOQPmnwfS2yFxa0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMMWKlQZ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMMWKlQZ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f0794fdb95so1193453a34.2
        for <iwd@lists.linux.dev>; Tue, 07 May 2024 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098991; x=1715703791; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12wR5/YDZ8yJBuA1i0mOqThNBuSxYK1q4/PbdorPW7k=;
        b=AMMWKlQZPH57g/QFWS2quXopEF9XBxxnYjAM5DcEIZkg2TFBYxi4db+0yun8BiogGq
         AOqAy4VYzMfhPlXShebs0U6deUOH7aUHwnor/0hSESi/YuQAE4Iw0dWI119TJq+wT8qI
         BMviLGAwLXZRKnuMQlVpCk1quPvBA/khjbQL6c8IBjpfqZmYbPbJdL8OHUlvA/vaV9w7
         WPzgcWK2LDaztNfqVBT5CpdJ4UYpVaZR1VVOynMC9JkphYbmomSJJRmAl0tve879IFXT
         qESJT+cDgOpahXlq3j+sP7I+UL18JAfp416vXIUwPu8LHr4s3rLp21rvLgsdxXGU4Sqv
         +w5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098991; x=1715703791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12wR5/YDZ8yJBuA1i0mOqThNBuSxYK1q4/PbdorPW7k=;
        b=tGBY4IavfXx/yOnaxIMdU6lQG/oaLiyeLv3kFfvHxh/abnVr6dLrmdkR1EyzaJ2OxH
         F3aFvYSF/7xyY481xDsf6eRHQh2Y78gQa6DUwaz2g8nGcXnww00RQdAhehAYVMQG+/ue
         4KAymnz/SPxvxDPCuif8JjIhYuln3AqGcikRJ8nAlTpcrGXtD5saLz5+lDW1Y2cw+948
         aeO8in2dDfio6AkfQ6pBI0zSxLUN/ohQlsduMRoDDZXMNHi7y5yVVYZXv+CctTjZCJ+q
         aNpYDfwbJCU0A3tEMPeeWWp+nboWu1f3OWiFwPdCiE/5StETbJIJVg1QyOup9CbJQb81
         18pA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyJTCu7K3rBvSOomKnYnC9qrjpJfsgxakjmr9YSiGoZu/mN1Q9XboZ0IxFLYDI0Ix9bqRmie3MpdozA4V7h0fZGXk
X-Gm-Message-State: AOJu0YzKysRR9jwBnJ6/Tldq5eTgAeO8ofvIAAPmtfnH5nSSxHib5qU/
	01Z7pjIA2LMok7GFeA5qDo0pcf2YMQJtxLyRvZeAgsdmhOjcv3yL
X-Google-Smtp-Source: AGHT+IGzRJsDLl9VYsUxU0NqJA3NDpIDrDmVMwwqo4CxT8Wq3DCgZ+g1piDu31HLEVzlqc41AWyczQ==
X-Received: by 2002:a9d:74d9:0:b0:6f0:67cf:625c with SMTP id a25-20020a9d74d9000000b006f067cf625cmr5886543otl.9.1715098991267;
        Tue, 07 May 2024 09:23:11 -0700 (PDT)
Received: from [192.168.1.20] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id cl8-20020a05683064c800b006ef0f290550sm2518984otb.31.2024.05.07.09.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:23:11 -0700 (PDT)
Message-ID: <b2fa3788-dce9-4ce5-81a9-b4fd7e4acaf3@gmail.com>
Date: Tue, 7 May 2024 11:23:10 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] Basic WPA3 support in AP mode
To: John Brandt <brandtwjohn@gmail.com>, iwd@lists.linux.dev
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

On 5/5/24 7:30 PM, John Brandt wrote:
> This set of patches adds basic WPA3 support for IWD in AP mode. It has
> been tested by connecting to IWD AP using wpa_supplicant, both when WPA3
> is enabled and when it was not. A unit test for SAE mode is now also
> included and all other unit tests now pass again.
> 
> Compared to the previous version, this patch now also includes MFP
> support for AP mode. The AP will generate an IGTK on startup, and
> distribute it to MFP-capable clients. Sanity checks on received SAE
> frames are now also added.

Very nice series.  Thanks for doing this.  I applied what looked good and seemed 
safe to apply.  For the rest, please send a v3.

Thanks,
-Denis
