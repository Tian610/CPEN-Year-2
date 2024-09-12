package additionClosure;

import java.util.List;

public class AdditionClosure {

	public static boolean isClosed(List<Integer> intList, Integer n) {

		int foundInt;
		boolean isValid;

		for(int i = 0; i < intList.size();i++) {
			for(int j = 0; j < intList.size();j++) {
				if(j==i) {
					continue;
				} else {

					foundInt = (intList.get(i)+intList.get(j)) % n;

					isValid = false;
					for(int a = 0; a < intList.size(); a++) {
						if(Math.abs(intList.get(a)-foundInt) % n == 0) {
							isValid=true;
							break;
						}
					}

					if(!isValid) {
						return false;
					}
				}
			}
		}

		return true;
	}	
}