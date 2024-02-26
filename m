Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A663B
	for <iwd@lists.linux.dev>; Mon, 26 Feb 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942340; cv=none; b=pgaKzgRz/6B1wxhjZbv4erzEL3iTv9H7kqI28VK5Q5I8wOUHrAEP1TKrcyoVpavjtuPkFBGb+VYPqtkACWBZmsq7PiXrMPfPV1X1PRxSBlKtSbOSSjex8ip8F/ta6/la6w4yVzRTuujcbr1nqcqeMypvRwpcnQF6FRyo9w5dE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942340; c=relaxed/simple;
	bh=NlMRjZgSYGqxiXBNedj4i4y4l+EDAimcBzfgyxYMaog=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av9p9X7PcmcSVd/434ciVZLR4FiRfSa47QRxbubaSzORTwZanfTISvUq06bq1au+zs4OJYdwuny/tfXgza659RehHDHxRNqvEO76AQXqQUAh2iI4SDym8YVsrcdTdIBA5GpTPfeTJ0GFuwQq5G9eprU/K4sW37grBV8O/m9mCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no; spf=pass smtp.mailfrom=yartys.no; dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b=G68wOVfN; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yartys.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yartys.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yartys.no header.i=@yartys.no header.b="G68wOVfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yartys.no;
	s=protonmail2; t=1708942333; x=1709201533;
	bh=NlMRjZgSYGqxiXBNedj4i4y4l+EDAimcBzfgyxYMaog=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G68wOVfN1vsWze4FpCA5m6wArVUMLU8tqaqYs8nvecR193u8g0/eCBwsr0YkyQsA3
	 7uj0O2W+3ZiKGgmAdxFHfGE0NKERqG1n9tCld8vIisPBBlnd34i2+J505bDSNGn+Mc
	 M2t/hQ1DMWhoLpDb5p7SN93BcvN3SbXJDlzCUKXyn72lDgNyflFwxWRotKKZ09lZBL
	 lDQnl3GPsd4ZX0bHDarqmaAf2JgcYVDbQiQ5APVzUIbt37sMLU9MYpkj5M28sBVfh5
	 J+uoeZW+7X4HO2QWjba2sI3jAwhcTVFm0AGIwprV+TPWTdom1LsLezRssP5KAeaHQf
	 ukRlWr6sI6x0Q==
Date: Mon, 26 Feb 2024 10:11:58 +0000
To: Denis Kenzior <denkenz@gmail.com>
From: Michael Yartys <mail@yartys.no>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
Subject: Re: Unable to connect to eduroam
Message-ID: <vqF6dK8_OQ-Y9yl4JhGbaEBuh02Um6vk4WdWmjWUxKW1btlFH3WAqmxHhwMznuU02O2ZIYNQK23HhD_qUuFJoNvHCe2UC2LFqS9xFV_ltvk=@yartys.no>
In-Reply-To: <ghq_OJQ1so1_7JGCGGTtn5Go_9tm_ZbROdd1umG7CzQ5G95vXzLCzCfWCbGjO4IBU2ZKzM1dmSUOCrKlsPhuDMbTVcJivxvPOXHBYPU6IyM=@yartys.no>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no> <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com> <oNiRr7aqwSLhickml0qZlRg5tAZ_r_d5KphKztkhii6KjSMvQ0-pYjNo-8NujElHLPJoc9ho9v8X3zD71jQ6O5pdzdTXqFF1T0x2dBQ9Oc0=@yartys.no> <f411612a-3d8c-47c8-abc1-41dda98e7732@gmail.com> <ghq_OJQ1so1_7JGCGGTtn5Go_9tm_ZbROdd1umG7CzQ5G95vXzLCzCfWCbGjO4IBU2ZKzM1dmSUOCrKlsPhuDMbTVcJivxvPOXHBYPU6IyM=@yartys.no>
Feedback-ID: 77365699:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

> I'll try to downgrade to version 6.6.14 and give it a try on Monday when =
I'm back at the uni.

Just wanted to say that it works with kernel version 6.6.14. Guess I'll hav=
e to report this upstream.

Michael
