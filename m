Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57F18D644
	for <iwd@lists.linux.dev>; Tue,  6 Aug 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954787; cv=none; b=r/yVNzlUM6hFJcaJVLe6YG2e7XOF+vlnwYWUT7ohxWV9yBR1ZzrCiK/u3BMqVspIkYStetAawcP9czhaFw4SOovIb0y7s/dwH/Q/SKsOgstFZhEAzvvLG6zHEeqxEnfJfbyKBrOWNuMHdTfriMkMkFIKEkXcKBrbS6MoFr5PLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954787; c=relaxed/simple;
	bh=9XhUj1UFHqx4olmYVzgahC5p+KckVU1IMLzu7GLdPHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fd5LvpWk3Gj/nG14wv9KI3Rk8XPMEP7zC2G6ByTFFbldeGDTS2dWgQvu52IPoUwks1g1gALXWet181+z7j6TBaLmHYtJINwvbeBH/4jT9AG6mQ8h5GHzGP85yOJ+oa+ZsCTKw8tCUFO5ZMivz2XlsOV003I8Hjbl4NVyuXkD/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5Qsb36A; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5Qsb36A"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70943b07c2cso410951a34.1
        for <iwd@lists.linux.dev>; Tue, 06 Aug 2024 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954785; x=1723559585; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKHnoDZ/vkRjlipyh1da2VcfX0/5Hlk/P6E3Tf18CWU=;
        b=V5Qsb36A09jVJNdvhsSOMlsnvoEHcSq5BwTsL0eFJGAy0HTM41GxEAUN0wB5oAQNVx
         PA/xwgejqUHIr/+XZ3fsJrfMF0TLGSaQ3sNhC+shD929zNe9/PNSjAuTGufTv96hftEs
         6xV5f9eqrlxavjutuwbzSveny60oVuKW0UvLGB6ZbZ6BFjNDKRixSft+Rxt55/WRUtCi
         XZA4vsksc7rBZwI4YVz+8GjE+vivkfO1+KN2BnsVHPAXKsNtOJapbDtPBtCdBTuMV1TL
         n/ATTkFXhyJ0y67XwOA9HNZbEr9rx/RKX1E0tSYA5MWd3hvs8KTyPczJsvREBOWw8G/G
         h3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954785; x=1723559585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKHnoDZ/vkRjlipyh1da2VcfX0/5Hlk/P6E3Tf18CWU=;
        b=e0/O9yQZrLDOx7hT06LUq8qU14YIR4pOciniXZriLdvcri76i7HoLhlHoVXwyZ77Iw
         n6qNbbcoxuvKVfLiiNk660Ja1FuJJ/yHvBtr1+AuxAQX9eN4OCxIrllVw+T0Ti6cR3sA
         7NjTCCzv8eb+kH0nNntMmMB2H7vuttPgAqs7hrNfvaiwUykg1FO26O5dGTXuo3CnCMfS
         apA2JZ3uLh/y4GQ7Qv49X41p8IhhjRWF67otyeZT0vXWK+Cc8VWl6YnUQsKUaa/TBmBa
         kY7rAf1lFEevTVXRPLXdVo9pOkVm0G41BuuwARS1HmwZdB3Jq4iehMq1PJG+ipX0EJfh
         029A==
X-Gm-Message-State: AOJu0YwWo9eT9WmGWpFRN08gk2yofrq1JnSka6kNHR8rcFl3XeaSWxBH
	HV69DBYyuhk6zuuSMoPsvEJqsewC+VJNeNdtEW7j7e6wtC17GbQtqT72gA==
X-Google-Smtp-Source: AGHT+IE1dXLJYrq8GhNIbyGG9nL7JJ/xNZJo57K3D0ElLIV+O2ODQP0ZQIXv0/qCsJy4N8QWzkUBBw==
X-Received: by 2002:a05:6830:698f:b0:704:4abf:c0d6 with SMTP id 46e09a7af769-709b33436b7mr20048149a34.20.1722954785246;
        Tue, 06 Aug 2024 07:33:05 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70a3a7501d4sm3850616a34.59.2024.08.06.07.33.04
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:33:04 -0700 (PDT)
Message-ID: <e6854941-2c81-4f7d-a69b-ab89f49bb3d8@gmail.com>
Date: Tue, 6 Aug 2024 09:33:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] monitor: Decode RMNet Mux Identifier
To: iwd@lists.linux.dev
References: <20240805140721.57518-1-denkenz@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 9:07 AM, Denis Kenzior wrote:
> ---
>   monitor/nlmon.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Applied

